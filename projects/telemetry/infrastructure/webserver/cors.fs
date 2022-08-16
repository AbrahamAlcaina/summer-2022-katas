module Infrastructure.Cors

open Microsoft.AspNetCore.Cors.Infrastructure

let bootstrap (builder: CorsPolicyBuilder) =
    builder
        .WithOrigins("http://localhost:80")
        .AllowAnyMethod()
        .AllowAnyHeader()
    |> ignore
