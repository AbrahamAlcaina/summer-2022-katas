module Infrastructure.Environment

open System
open Interfaces
open FsToolkit.ErrorHandling.ValidationCE
open FsToolkit.ErrorHandling


let bootstrap () =
    let name = Environment.GetEnvironmentVariable "STORAGE_NAME"

    result {
        let! storageName = StorageName.TryCreate name

        return { StorageName = storageName }
    }
