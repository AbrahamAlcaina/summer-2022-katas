targetScope = 'subscription'
///////////////////////////////////////////////////////////////////////////////
// INPUT PARAMETERS
///////////////////////////////////////////////////////////////////////////////
@description('Subscrition id where to deploy the azure container registry')
param subscriptionId string

@description('Location for the resourceGroup and other resources')
@allowed(
  [ 'westeurope', 'francecentral' ]
)
param location string

@description('Name of the resourceGroup to create')
param environment string = 'registry'

///////////////////////////////////////////////////////////////////////////////
/// Resource Group
///////////////////////////////////////////////////////////////////////////////
module rg '../resourceGroup.bicep' = {
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

module storageAccount 'containerRegistry.bicep' = {
  name: 'acr-${environment}'
  params: {
    location: location
  }
  dependsOn: [ rg ]
  scope: resourceGroup(rg.name)
}
