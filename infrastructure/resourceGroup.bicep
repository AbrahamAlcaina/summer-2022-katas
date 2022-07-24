targetScope = 'subscription'

param resourceNameGroup string
param resourceGroupLocation string = 'dev'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceNameGroup
  location: resourceGroupLocation
}

output rg object = rg
