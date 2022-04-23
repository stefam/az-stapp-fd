# Azure Static Web App + Azure Classic Frontdoor + Azure CLI.
This tutorial is meant to help you to create an Azure based application behind a gobally availabel load balancer solution.
This tutorial assumes that you have Azure, Git and Github basic knowledge.

## Steps
### 1. Create github repository.

### 2. Create the app.
`npx create-react-app {app name} --template typescript`

### 3. Push code to github repository.

### 4. Create azure resource group.
`az group create --location {location} --name {resource group name}`

### 5. Create azure static web app from ARM template.
- Get a personal access token [repository token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

- Run az cli:\
  `az staticwebapp create -n {app name} -s https://github.com/{repo path} -b {branch name} -l {location} -g {resource group name} -t {personal token}`

### 6. Create azure classic front door.
`az network front-door create --name {front dor resource name} --resource-group {resource group name} --accepted-protocols Http Https --backend-address {static web app host url}`

### 7. Create staticwebapp.config.json file on repository root folder.
- Add static web app config networking node:\
  `"networking": { "allowedIpRanges": ["AzureFrontDoor.Backend"] }`

- Add static web app config forwardingGateway node:\
  `"forwardingGateway": {
    "requiredHeaders": {
      "X-Azure-FDID": "8833fd05-b47c-4659-b280-61951f8c5b2e"
    },
    "allowedForwardedHosts": ["fd-demo-prod-001.azurefd.net"]
  }`

## Help links:
- [Reference tutorial.](https://docs.microsoft.com/en-us/azure/static-web-apps/front-door-manual)
- [Azure resources naming convention.](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Azure resources abbreviations.](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
