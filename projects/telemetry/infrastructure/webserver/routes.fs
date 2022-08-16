module Infrastructure.Routes

open Interfaces

open Giraffe
open Dapr.Client
open System
open UseCase.ReceiveTelemetryFromDevice

let saveHandler (env: EnvironmentVariables) : HttpHandler =
    handleContext (fun ctx ->
        let dapr = ctx.GetService<DaprClient>()
        // TODO DESERIALIZE
        let deviceId = "device-id"
        let storageName = env.StorageName |> StorageName.value
        let save = Repository.Telemetry.save dapr storageName

        let data =
            { deviceId = deviceId
              timestamp = DateTimeOffset.UtcNow.ToIsoString()
              temperature = 35.5 }

        task {
            do! receiveTelemetryFromDevice save data
            return! data.ToString() |> ctx.WriteTextAsync
        })


let getWebApp env =
    choose [ GET >=> choose [ route "/" >=> text "hola" ]
             POST
             >=> choose [ route "/save" >=> (saveHandler env) ]
             setStatusCode 404 >=> text "Not Found" ]
