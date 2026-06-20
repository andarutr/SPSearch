namespace SPSearch.Server.Models;

public class SearchRequest
{
    public string Server { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public int Port { get; set; } = 1433;
    public bool TrustedConnection { get; set; }
    public bool TrustServerCertificate { get; set; }
    public string Database { get; set; } = string.Empty;
    public string? Table { get; set; }
    public List<string> Columns { get; set; } = [];
}
