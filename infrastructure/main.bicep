targetScope = 'subscription'

///////////////////////////////////////////////////////////////////////////////
// INPUT PARAMETERS
///////////////////////////////////////////////////////////////////////////////
@description('Subscrition id where to deploy')
param subscriptionId string

@description('Location for the resourceGroup and other resources')
@allowed(
  [ 'westeurope', 'francecentral' ]
)
param location string

@description('Name of the resourceGroup to create')
param environment string = 'dev'

///////////////////////////////////////////////////////////////////////////////
/// Resource Group
///////////////////////////////////////////////////////////////////////////////
module rg 'resourceGroup.bicep' = {
  name: 'rg-${environment}'
  params: {
    resourceNameGroup: 'rg-${environment}'
    resourceGroupLocation: location
  }
  scope: subscription(subscriptionId)
}

///////////////////////////////////////////////////////////////////////////////
/// STORAGE 
///////////////////////////////////////////////////////////////////////////////
module storageAccount 'storage.bicep' = {
  name: 'sa${environment}summerkatas' // only leters lower case or numbers 3-24
  params: {
    storageName: 'sa${environment}summerkatas'
    location: location
  }
  dependsOn: [ rg ]
  scope: resourceGroup(rg.name)
}

///////////////////////////////////////////////////////////////////////////////
/// IOT HUB 
///////////////////////////////////////////////////////////////////////////////
param iotHubName string = 'summer-katas'

module iotHub 'iotHub.bicep' = {
  name: 'iotHub-${environment}-${iotHubName}'
  params: {
    location: location
    iotHubName: 'iotHub-${environment}-${iotHubName}'
  }
  dependsOn: [ rg ]
  scope: resourceGroup(rg.name)
}

///////////////////////////////////////////////////////////////////////////////
/// APP CONTAINER ENVIRONMENT
///////////////////////////////////////////////////////////////////////////////
module AppContarinerEnvironment 'enviroment.bicep' = {
  name: 'appContainer-${environment}'
  params: {
    location: location
    environment_name: 'appContainer-${environment}'
    storageAccountName: storageAccount.outputs.storageAccountName
    storageContainerName: storageAccount.outputs.storageAccountContainerName
  }
  dependsOn: [ storageAccount ]
  scope: resourceGroup(rg.name)
}
