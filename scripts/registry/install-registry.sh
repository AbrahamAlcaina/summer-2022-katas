#!/bin/bash

# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

az deployment sub create \
  --location=$LOCATION \
  --template-file ../infrastructure/containerRegistry/main.bicep \
  --parameters subscriptionId=$SUBSCRIPTION_ID \
    location=$LOCATION \
    