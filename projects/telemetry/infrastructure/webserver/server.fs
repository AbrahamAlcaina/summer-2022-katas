module Infrastructure.Server

open System
open Microsoft.AspNetCore.Builder
open Microsoft.AspNetCore.Hosting
open Microsoft.Extensions.Logging
open Microsoft.Extensions.DependencyInjection
open Giraffe

open Interfaces
// let saveOnMongo =
//     handleContext (fun ctx ->
//         task {
//             let darp = ctx.GetService<DaprClient>()
//             let deviceId = "device-id"

//             let data: TelemetryData =
//                 { deviceId = deviceId
//                   timestamp = DateTimeOffset.UtcNow.ToIsoString()
//                   temperature = 35.5 }

//             do! darp.SaveStateAsync("mongo", $"{deviceId}_{data.timestamp}", data)

//             return! data.ToString() |> ctx.WriteTextAsync
//         })

let errorHandler (ex: Exception) (logger: ILogger) =
    logger.LogError(ex, "An unhandled exception has occurred while executing the request.")

    clearResponse
    >=> setStatusCode 500
    >=> text ex.Message



// ---------------------------------
// Config and Main
// ---------------------------------



let configureApp (environment: EnvironmentVariables) (app: IApplicationBuilder) =
    let env = app.ApplicationServices.GetService<IWebHostEnvironment>()
    let routes = Routes.getWebApp environment

    match env.EnvironmentName.Equals("Development") with
    | true -> app.UseDeveloperExceptionPage()
    | false -> app.UseGiraffeErrorHandler errorHandler
    |> ignore

    app.UseGiraffe(routes)
    app.UseCors(Cors.bootstrap) |> ignore

let bootstrap (env: EnvironmentVariables) =
    WebHostBuilder()
        .UseKestrel()
        .Configure(Action<IApplicationBuilder>(configureApp env))
        .ConfigureServices(Services.bootstrap)
        .ConfigureLogging(Login.bootstrap)
        .Build()
        .Run()
