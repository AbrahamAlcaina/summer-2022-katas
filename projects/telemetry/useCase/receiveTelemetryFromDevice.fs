module UseCase.ReceiveTelemetryFromDevice

open Interfaces
open System.Threading.Tasks


type Save = TelemetryData -> Task
type receive = Save -> TelemetryData -> Task

let receiveTelemetryFromDevice: receive = fun save data -> save data
