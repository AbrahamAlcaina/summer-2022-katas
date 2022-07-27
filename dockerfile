# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS base
WORKDIR /app

RUN dotnet new tool-manifest
RUN dotnet tool install Paket
RUN dotnet tool restore

COPY ./projects/.paket ./.paket
COPY ./projects/paket* ./
COPY ./projects/iot.sln  ./
COPY ./projects/ ./projects
RUN dotnet paket install  
RUN dotnet paket restore  

# Telemetry
FROM base AS telemetry-builder
WORKDIR /app/projects/telemetry
RUN dotnet tool restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS telemetry-app
WORKDIR /app
COPY --from=telemetry-builder /app/projects/telemetry/out .
EXPOSE 8080
ENTRYPOINT ["dotnet", "telemetry.dll"]


