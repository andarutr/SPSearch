using Microsoft.Data.SqlClient;
using SPSearch.Server.Models;

namespace SPSearch.Server.Services;

public class SchemaSearchService
{
    private string BuildConnectionString(string server, string username, string password, int port, string database, bool trustedConnection, bool trustServerCert)
    {
        var builder = new SqlConnectionStringBuilder
        {
            DataSource = port == 1433 ? server : $"{server},{port}",
            InitialCatalog = database,
            TrustServerCertificate = trustServerCert,
            ConnectTimeout = 10
        };

        if (trustedConnection)
        {
            builder.IntegratedSecurity = true;
        }
        else
        {
            builder.UserID = username;
            builder.Password = password;
        }

        return builder.ConnectionString;
    }

    public async Task<bool> TestConnectionAsync(ConnectionRequest req)
    {
        var cs = BuildConnectionString(req.Server, req.Username, req.Password, req.Port, "master", req.TrustedConnection, req.TrustServerCertificate);
        using var conn = new SqlConnection(cs);
        await conn.OpenAsync();
        return true;
    }

    public async Task<List<DatabaseInfo>> GetDatabasesAsync(ConnectionRequest req)
    {
        var dbs = new List<DatabaseInfo>();
        var cs = BuildConnectionString(req.Server, req.Username, req.Password, req.Port, "master", req.TrustedConnection, req.TrustServerCertificate);
        using var conn = new SqlConnection(cs);
        await conn.OpenAsync();

        using var cmd = new SqlCommand(
            "SELECT name FROM sys.databases ORDER BY name", conn);
        using var reader = await cmd.ExecuteReaderAsync();

        while (await reader.ReadAsync())
            dbs.Add(new DatabaseInfo { Name = reader.GetString(0) });

        return dbs;
    }

    public async Task<List<TableInfo>> GetTablesAsync(SearchRequest req)
    {
        var tables = new List<TableInfo>();
        var cs = BuildConnectionString(req.Server, req.Username, req.Password, req.Port, req.Database, req.TrustedConnection, req.TrustServerCertificate);
        using var conn = new SqlConnection(cs);
        await conn.OpenAsync();

        using var cmd = new SqlCommand(
            "SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES " +
            "WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_SCHEMA, TABLE_NAME", conn);
        using var reader = await cmd.ExecuteReaderAsync();

        while (await reader.ReadAsync())
            tables.Add(new TableInfo { Schema = reader.GetString(0), Name = reader.GetString(1) });

        return tables;
    }

    public async Task<SearchResponse> ExecuteSearchAsync(SearchRequest req)
    {
        var results = new List<SearchResultRow>();
        var cs = BuildConnectionString(req.Server, req.Username, req.Password, req.Port, req.Database, req.TrustedConnection, req.TrustServerCertificate);

        using var conn = new SqlConnection(cs);
        await conn.OpenAsync();

        var whereClauses = new List<string>();
        var parameters = new List<SqlParameter>();

        for (int i = 0; i < req.Columns.Count; i++)
        {
            var paramName = $"@col{i}";
            whereClauses.Add($"COLUMN_NAME LIKE {paramName}");
            parameters.Add(new SqlParameter(paramName, $"%{req.Columns[i]}%"));
        }

        var where = string.Join(" OR ", whereClauses);
        var tableFilter = string.IsNullOrEmpty(req.Table)
            ? ""
            : $" AND TABLE_SCHEMA + '.' + TABLE_NAME = @table";

        if (!string.IsNullOrEmpty(req.Table))
            parameters.Add(new SqlParameter("@table", req.Table));

        var sql = $"SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE " +
                  $"FROM [{req.Database}].INFORMATION_SCHEMA.COLUMNS " +
                  $"WHERE ({where}){tableFilter} " +
                  $"ORDER BY TABLE_SCHEMA, TABLE_NAME, ORDINAL_POSITION";

        using var cmd = new SqlCommand(sql, conn);
        cmd.Parameters.AddRange([.. parameters]);

        using var reader = await cmd.ExecuteReaderAsync();

        var tableSet = new HashSet<string>();

        while (await reader.ReadAsync())
        {
            var row = new SearchResultRow
            {
                TableSchema = reader.GetString(0),
                TableName = reader.GetString(1),
                ColumnName = reader.GetString(2),
                DataType = reader.GetString(3)
            };
            results.Add(row);
            tableSet.Add($"{row.TableSchema}.{row.TableName}");
        }

        var logFile = await WriteLogAsync(req, results);

        return new SearchResponse
        {
            Results = results,
            TotalTables = tableSet.Count,
            LogFile = logFile
        };
    }

    private async Task<string> WriteLogAsync(SearchRequest req, List<SearchResultRow> results)
    {
        var logDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Logs");
        Directory.CreateDirectory(logDir);

        var timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
        var fileName = $"search_{timestamp}.txt";
        var fullPath = Path.Combine(logDir, fileName);

        var lines = new List<string>
        {
            "========================================",
            "SPSearch — Search Log",
            $"Date: {DateTime.Now:yyyy-MM-dd HH:mm:ss}",
            $"Server: {req.Server}",
            $"Database: {req.Database}",
            $"Table Filter: {req.Table ?? "(all tables)"}",
            $"Columns Searched: {string.Join(", ", req.Columns)}",
            "========================================",
            "",
            "Results:"
        };

        foreach (var r in results)
            lines.Add($"[{req.Database}].[{r.TableSchema}].[{r.TableName}] → {r.ColumnName} ({r.DataType})");

        var tableCount = results.Select(r => $"{r.TableSchema}.{r.TableName}").Distinct().Count();
        lines.Add("");
        lines.Add("========================================");
        lines.Add($"{tableCount} tables found containing requested columns.");
        lines.Add("========================================");

        await File.WriteAllLinesAsync(fullPath, lines);
        return fileName;
    }
}
