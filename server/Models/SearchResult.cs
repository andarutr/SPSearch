namespace SPSearch.Server.Models;

public class SearchResultRow
{
    public string TableSchema { get; set; } = string.Empty;
    public string TableName { get; set; } = string.Empty;
    public string ColumnName { get; set; } = string.Empty;
    public string DataType { get; set; } = string.Empty;
}

public class SearchResponse
{
    public List<SearchResultRow> Results { get; set; } = [];
    public int TotalTables { get; set; }
    public string LogFile { get; set; } = string.Empty;
}
