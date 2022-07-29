#!/bin/bash
dapr dashboard -p 7777 &
dapr run --app-port 80 --app-id telemetry-app --dapr-http-port 8880 --components-path ../components/ \
 --log-level info -- dotnet watch run -p ../projects/telemetry/telemetry.fsproj &
