targetScope = 'subscription'

@description('Subscrition id where to deploy')
param subscriptionId string

@description('Location for the resourceGroup and other resources')
@allowed(
  [ 'westeurope', 'francecentral' ]
)
param location string

@description('Name of the resourceGroup to create')
param resourceNameGroup string = 'dev'

param dateTime string = utcNow()

module rg 'resourceGroup.bicep' = {
  name: 'rg-${resourceNameGroup}-${dateTime}'
  params: {
    resourceNameGroup: resourceNameGroup
    resourceGroupLocation: location
  }
  scope: subscription(subscriptionId)
}

param iotHubName string = 'summer-katas'

module iotHub 'iotHub.bicep' = {
  name: 'iotHub-${iotHubName}-${dateTime}'
  params: {
    location: location
    iotHubName: 'iotHub-${iotHubName}-${dateTime}'
  }
  dependsOn: [ rg ]
  scope: resourceGroup(resourceNameGroup)
}
