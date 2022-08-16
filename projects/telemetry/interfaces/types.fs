module Interfaces

open System

type TelemetryData =
    { deviceId: string
      timestamp: string
      temperature: float }


type StorageName = private StorageName of string


module StorageName =
    let value (StorageName value) = value

    let TryCreate name =
        if String.IsNullOrEmpty name then
            Error "The storage name should have a value"
        else
            Ok <| StorageName name

type EnvironmentVariables = { StorageName: StorageName }
