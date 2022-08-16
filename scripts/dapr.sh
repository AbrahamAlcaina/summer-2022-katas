#!/bin/bash

export MONGO_HOST=localhost:27017

dapr run --app-port 80 \
 --app-id telemetry-app \
 --dapr-http-port 8880 \
 --components-path ../components/ \
 --log-level info -- \
  dotnet watch run --project ../projects/telemetry/telemetry.fsproj


kill $(lsof -t -i:57702)