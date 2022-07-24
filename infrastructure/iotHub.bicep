param iotHubName string = 'IoT-Hub'
param location string = resourceGroup().location

resource iotHub 'Microsoft.Devices/IotHubs@2021-07-02' = {
  name: iotHubName
  location: location
  sku: {
    name: 'F1' // Free (Standard)	F1	8,000
    capacity: 1
  }
}

output iotHub object = iotHub
