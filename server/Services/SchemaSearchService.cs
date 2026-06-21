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

        var tableNameClauses = new List<string>();
        if (req.TableNames is { Count: > 0 })
        {
            for (int i = 0; i < req.TableNames.Count; i++)
            {
                var paramName = $"@tbl{i}";
                tableNameClauses.Add($"TABLE_NAME LIKE {paramName}");
                parameters.Add(new SqlParameter(paramName, $"%{req.TableNames[i]}%"));
            }
        }

        var tableFilter = string.IsNullOrEmpty(req.Table)
            ? ""
            : $" AND TABLE_SCHEMA + '.' + TABLE_NAME = @table";

        if (!string.IsNullOrEmpty(req.Table))
            parameters.Add(new SqlParameter("@table", req.Table));

        var andClauses = new List<string> { $"({where})" };
        if (tableNameClauses.Count > 0)
            andClauses.Add($"({string.Join(" OR ", tableNameClauses)})");

        var sql = $"SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE " +
                  $"FROM [{req.Database}].INFORMATION_SCHEMA.COLUMNS " +
                  $"WHERE {string.Join(" AND ", andClauses)}{tableFilter} " +
                  $"ORDER BY TABLE_SCHEMA, TABLE_NAME, ORDINAL_POSITION";

        var tableSet = new HashSet<string>();

        using (var cmd = new SqlCommand(sql, conn))
        {
            cmd.Parameters.AddRange([.. parameters]);

            using (var reader = await cmd.ExecuteReaderAsync())
            {
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
            }
        }

        // Procedure search
        var procedureResults = new List<ProcedureSearchResult>();
        var procParams = new List<SqlParameter>();
        var procConditions = new List<string>();

        if (req.Procedures is { Count: > 0 })
        {
            var inClauses = new List<string>();
            for (int i = 0; i < req.Procedures.Count; i++)
            {
                var paramName = $"@proc{i}";
                inClauses.Add(paramName);
                procParams.Add(new SqlParameter(paramName, req.Procedures[i]));
            }
            procConditions.Add($"s.name + '.' + p.name IN ({string.Join(", ", inClauses)})");
        }

        if (req.SpNames is { Count: > 0 })
        {
            var nameClauses = new List<string>();
            for (int i = 0; i < req.SpNames.Count; i++)
            {
                var paramName = $"@spn{i}";
                nameClauses.Add($"p.name LIKE {paramName}");
                procParams.Add(new SqlParameter(paramName, $"%{req.SpNames[i]}%"));
            }
            procConditions.Add($"({string.Join(" OR ", nameClauses)})");
        }

        if (req.SpParams is { Count: > 0 })
        {
            var paramClauses = new List<string>();
            for (int i = 0; i < req.SpParams.Count; i++)
            {
                var paramName = $"@spp{i}";
                paramClauses.Add($"par.name LIKE {paramName}");
                procParams.Add(new SqlParameter(paramName, $"%{req.SpParams[i]}%"));
            }
            procConditions.Add($"EXISTS (SELECT 1 FROM sys.parameters par WHERE par.object_id = p.object_id AND ({string.Join(" OR ", paramClauses)}))");
        }

        var procWhere = procConditions.Count > 0 ? "WHERE " + string.Join(" AND ", procConditions) : "";

        var procSql = $"SELECT DISTINCT s.name, p.name, m.definition " +
                      $"FROM sys.procedures p " +
                      $"JOIN sys.schemas s ON p.schema_id = s.schema_id " +
                      $"JOIN sys.sql_modules m ON p.object_id = m.object_id " +
                      $"{procWhere} " +
                      $"ORDER BY s.name, p.name";

        using (var procCmd = new SqlCommand(procSql, conn))
        {
            if (procParams.Count > 0)
                procCmd.Parameters.AddRange([.. procParams]);

            using var procReader = await procCmd.ExecuteReaderAsync();
            while (await procReader.ReadAsync())
            {
                procedureResults.Add(new ProcedureSearchResult
                {
                    ProcedureSchema = procReader.GetString(0),
                    ProcedureName = procReader.GetString(1),
                    Definition = procReader.IsDBNull(2) ? "" : procReader.GetString(2)
                });
            }
        }

        var logFile = await WriteLogAsync(req, results, procedureResults);

        return new SearchResponse
        {
            Results = results,
            TotalTables = tableSet.Count,
            ProcedureResults = procedureResults,
            TotalProcedures = procedureResults.Count,
            LogFile = logFile
        };
    }

    public async Task<List<ProcedureInfo>> GetProceduresAsync(SearchRequest req)
    {
        var procedures = new List<ProcedureInfo>();
        var cs = BuildConnectionString(req.Server, req.Username, req.Password, req.Port, req.Database!, req.TrustedConnection, req.TrustServerCertificate);
        using var conn = new SqlConnection(cs);
        await conn.OpenAsync();

        using var cmd = new SqlCommand(
            "SELECT s.name, p.name FROM sys.procedures p " +
            "JOIN sys.schemas s ON p.schema_id = s.schema_id " +
            "ORDER BY s.name, p.name", conn);
        using var reader = await cmd.ExecuteReaderAsync();

        while (await reader.ReadAsync())
            procedures.Add(new ProcedureInfo { Schema = reader.GetString(0), Name = reader.GetString(1) });

        return procedures;
    }

    public async Task<TableSchemaResponse> GetTableSchemaAsync(SearchRequest req)
    {
        var cs = BuildConnectionString(req.Server, req.Username, req.Password, req.Port, req.Database!, req.TrustedConnection, req.TrustServerCertificate);

        using var conn = new SqlConnection(cs);
        await conn.OpenAsync();

        var columns = new List<ColumnInfo>();

        using (var cmd = new SqlCommand(
            "SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH " +
            "FROM INFORMATION_SCHEMA.COLUMNS " +
            "WHERE TABLE_SCHEMA = @schema AND TABLE_NAME = @table " +
            "ORDER BY ORDINAL_POSITION", conn))
        {
            cmd.Parameters.AddWithValue("@schema", req.TableSchema!);
            cmd.Parameters.AddWithValue("@table", req.TableName!);

            using var reader = await cmd.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                columns.Add(new ColumnInfo
                {
                    ColumnName = reader.GetString(0),
                    DataType = reader.GetString(1),
                    IsNullable = reader.GetString(2),
                    MaxLength = reader.IsDBNull(3) ? null : (int?)reader.GetInt32(3)
                });
            }
        }

        var sampleRecords = new List<Dictionary<string, object?>>();

        using (var cmd = new SqlCommand(
            $"SELECT TOP 3 * FROM [{req.Database}].[{req.TableSchema}].[{req.TableName}]", conn))
        using (var reader = await cmd.ExecuteReaderAsync())
        {
            var schemaTable = await reader.GetColumnSchemaAsync();

            while (await reader.ReadAsync())
            {
                var record = new Dictionary<string, object?>();
                for (int i = 0; i < schemaTable.Count; i++)
                {
                    record[schemaTable[i].ColumnName] = reader.IsDBNull(i) ? null : reader.GetValue(i);
                }
                sampleRecords.Add(record);
            }
        }

        return new TableSchemaResponse
        {
            TableName = $"{req.TableSchema}.{req.TableName}",
            Columns = columns,
            SampleRecords = sampleRecords
        };
    }

    private async Task<string> WriteLogAsync(SearchRequest req, List<SearchResultRow> results, List<ProcedureSearchResult> procedureResults)
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
            $"Table Names Filter: {(req.TableNames is { Count: > 0 } ? string.Join(", ", req.TableNames) : "(none)")}",
            $"Procedure Filter: {(req.Procedures is { Count: > 0 } ? string.Join(", ", req.Procedures) : "(all procedures)")}",
            $"SP Names Filter: {(req.SpNames is { Count: > 0 } ? string.Join(", ", req.SpNames) : "(none)")}",
            $"SP Params Filter: {(req.SpParams is { Count: > 0 } ? string.Join(", ", req.SpParams) : "(none)")}",
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

        if (procedureResults.Count > 0)
        {
            lines.Add("");
            lines.Add("Procedures Found:");
            foreach (var p in procedureResults)
                lines.Add($"[{req.Database}].[{p.ProcedureSchema}].[{p.ProcedureName}]");
        }

        await File.WriteAllLinesAsync(fullPath, lines);
        return fileName;
    }
}
