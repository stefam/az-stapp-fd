# Azure Static Web App + Azure Classic Frontdoor + Azure CLI.
This tutorial is meant to help you to create an Azure based application behind a gobally available load balancer solution.
This tutorial assumes that you have NPM, Azure, Git and Github basic knowledge.

## Steps
### 1. Create github repository

### 2. Create the app
`npx create-react-app {app name} --template typescript`

### 3. Push code to github repository

### 4. Create azure resource group
`az group create --location {location} --name {resource group}`

### 5. Create azure static web app
- Get a personal access token [repository token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

- Run az cli:\
  `az staticwebapp create -n {app name} -s https://github.com/{repo path} -b {branch} -l {location} -g {resource group} -t {personal token} --sku Standard`

- Update .github/workflows/{app url}.yml file. Set properties as following:
  - `app_location: "/"`
  - `api_location: ""`
  - `output_location: "build"`

### 6. Create azure classic front door
`az network front-door create --name {front door name} --resource-group {resource group} --accepted-protocols Http Https --backend-address {app FQDN}`

### 7. Create staticwebapp.config.json file on repository root folder
- Add static web app config networking node:\
  `"networking": { "allowedIpRanges": ["AzureFrontDoor.Backend"] }`

- Add static web app config forwardingGateway node:\
  `"forwardingGateway": {
    "requiredHeaders": {
      "X-Azure-FDID": "{Front Door ID}"
    },
    "allowedForwardedHosts": ["{Front Door host domain}"]
  }`

- You can run the following command to get Front Door ID:\
  `az network front-door show -n {front door name} -g {resource group} --query "frontdoorId"`

### Click [here](https://github.com/stefam/az-stapp-fd/blob/main/scripts/az-stapp-fd.sh) to see the full script.

## Images
<img src="https://github.com/stefam/az-stapp-fd/blob/main/diagram.png" alt="diagram" style="width: 400px;" />

## Ref links:
- [Reference tutorial.](https://docs.microsoft.com/en-us/azure/static-web-apps/front-door-manual)
- [Azure resources naming convention.](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Azure resources abbreviations.](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Azure Frontdoor CLI specs.](https://docs.microsoft.com/en-us/cli/azure/network/front-door?view=azure-cli-latest)
- [Azure Static Web App CLI specs.](https://docs.microsoft.com/en-us/cli/azure/staticwebapp?view=azure-cli-latest)
