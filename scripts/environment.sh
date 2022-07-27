#!/bin/bash
az login
az upgrade
az bicep install
az extension add --name containerapp --upgrade
az provider register --namespace Microsoft.App


