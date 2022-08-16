module Infrastructure.Services

open System.Text.Json
open System.Text.Json.Serialization
open Microsoft.Extensions.DependencyInjection
open Giraffe

let bootstrap (services: IServiceCollection) =
    services.AddCors() |> ignore
    services.AddDaprClient() |> ignore
    services.AddGiraffe() |> ignore


    let jsonOptions = JsonSerializerOptions()
    jsonOptions.Converters.Add(JsonFSharpConverter())
    services.AddSingleton(jsonOptions) |> ignore

    services.AddSingleton<Json.ISerializer, SystemTextJson.Serializer>()
    |> ignore
