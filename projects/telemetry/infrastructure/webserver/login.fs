module Infrastructure.Login

open Microsoft.Extensions.Logging

let bootstrap (builder: ILoggingBuilder) =
    builder
        .AddFilter(fun l -> l.Equals LogLevel.Error)
        .AddConsole()
        .AddDebug()
    |> ignore
