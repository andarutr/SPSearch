using Microsoft.AspNetCore.Mvc;
using SPSearch.Server.Models;
using SPSearch.Server.Services;

namespace SPSearch.Server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class SearchController : ControllerBase
{
    private readonly SchemaSearchService _service;

    public SearchController(SchemaSearchService service)
    {
        _service = service;
    }

    [HttpPost("connect")]
    public async Task<IActionResult> Connect([FromBody] ConnectionRequest req)
    {
        try
        {
            await _service.TestConnectionAsync(req);
            return Ok(new { success = true });
        }
        catch (Exception ex)
        {
            return BadRequest(new { success = false, message = ex.Message });
        }
    }

    [HttpPost("databases")]
    public async Task<IActionResult> GetDatabases([FromBody] ConnectionRequest req)
    {
        try
        {
            var dbs = await _service.GetDatabasesAsync(req);
            return Ok(dbs);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("tables")]
    public async Task<IActionResult> GetTables([FromBody] SearchRequest req)
    {
        try
        {
            var tables = await _service.GetTablesAsync(req);
            return Ok(tables);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("execute")]
    public async Task<IActionResult> Execute([FromBody] SearchRequest req)
    {
        try
        {
            var response = await _service.ExecuteSearchAsync(req);
            return Ok(response);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("schema")]
    public async Task<IActionResult> GetSchema([FromBody] SearchRequest req)
    {
        try
        {
            var response = await _service.GetTableSchemaAsync(req);
            return Ok(response);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpGet("log/{filename}")]
    public IActionResult DownloadLog(string filename)
    {
        var logDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Logs");
        var filePath = Path.Combine(logDir, filename);

        if (!System.IO.File.Exists(filePath))
            return NotFound(new { message = "Log file not found." });

        var content = System.IO.File.ReadAllText(filePath);
        return File(
            System.Text.Encoding.UTF8.GetBytes(content),
            "text/plain",
            filename
        );
    }
}
