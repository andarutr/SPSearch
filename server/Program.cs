using SPSearch.Server.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddSingleton<SchemaSearchService>();

var app = builder.Build();

var clientPath = Path.Combine(app.Environment.ContentRootPath, "..", "client");
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new Microsoft.Extensions.FileProviders.PhysicalFileProvider(
        Path.GetFullPath(clientPath)),
    ServeUnknownFileTypes = true
});

app.MapControllers();

app.MapFallbackToFile("index.html", new StaticFileOptions
{
    FileProvider = new Microsoft.Extensions.FileProviders.PhysicalFileProvider(
        Path.GetFullPath(clientPath))
});

app.Run();
