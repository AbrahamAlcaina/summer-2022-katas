#!/bin/bash
# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

az deployment sub create \
  --location=$LOCATION \
  --template-file ../infrastructure/main.bicep \
  --parameters subscriptionId=$SUBSCRIPTION_ID \
    location=$LOCATION \
    environment=$ENVIRONMENT \
    containerRegistryPassword=$CONTAINER_REGISTRY_PASSWORD \
    # iotHubName=summer-katas
    