param location string = resourceGroup().location
param environmnetId string
param containerRegistryPassword string

resource telemetry 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'telemetry-service'
  location: location
  properties: {
    managedEnvironmentId: environmnetId
    configuration: {
      ingress: {
        external: false
        targetPort: 80
      }
      dapr: {
        enabled: true
        appId: 'telemetry'
        appProtocol: 'http'
        appPort: 80
      }
      registries: [
        {
          passwordSecretRef: 'acr-password'
          server: 'acrregistrysummerkatas.azurecr.io'
          username: 'acrregistrysummerkatas'
        }
      ]
      secrets: [
        {
          name: 'acr-password'
          value: containerRegistryPassword
        }
      ]
    }
    template: {
      containers: [
        {
          image: 'acrregistrysummerkatas.azurecr.io/telemetry-app:0.0.2'
          name: 'telemetry'
          env: [
          ]
          resources: {
            cpu: json('0.25')
            memory: '0.5Gi'
          }
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 5
      }
    }
  }
}
