module telemtry

open Infrastructure
open FsToolkit.ErrorHandling

[<EntryPoint>]
let main args =
    result {
        let! env = Environment.bootstrap ()
        Server.bootstrap env
        return 0
    }
    |> Result.valueOr (konst -1)
