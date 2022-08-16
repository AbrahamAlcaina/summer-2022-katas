module Infrastructure.Repository.Telemetry

open Dapr.Client
open System.Threading.Tasks
open Interfaces


type Storage = string
type Save = DaprClient -> Storage -> TelemetryData -> Task

let save: Save =
    fun darp storage data -> task { do! darp.SaveStateAsync(storage, $"{data.deviceId}_{data.timestamp}", data) }
