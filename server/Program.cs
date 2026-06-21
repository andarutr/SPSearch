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

var sfOpts = new StaticFileOptions
{
    FileProvider = new Microsoft.Extensions.FileProviders.PhysicalFileProvider(
        Path.GetFullPath(clientPath))
};

app.MapFallbackToFile("home", "sign.html", sfOpts);
app.MapFallbackToFile("search", "search.html", sfOpts);
app.MapFallbackToFile("result", "result.html", sfOpts);

app.MapFallbackToFile("sign.html", sfOpts);

app.Run();
