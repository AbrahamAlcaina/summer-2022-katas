#!/bin/bash 
ACR_NAME="acrregistrysummerkatas"
ACR="$ACR_NAME.azurecr.io"

# az login
TOKEN=$(az acr login --name $ACR --expose-token --output tsv --query accessToken)
docker login $ACR --username 00000000-0000-0000-0000-000000000000 --password $TOKEN

version=$1
if [[ -z "$version" ]]; then
  version=latest
fi

docker build . --target=telemetry-app --tag=telemetry-app:$version
docker tag telemetry-app $ACR/telemetry-app:$version
docker push $ACR/telemetry-app:$version