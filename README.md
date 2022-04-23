# Azure Static Web App + Azure Classic Frontdoor + ARM + Azure CLI.
This tutorial is meant to help you to create an Azure based application behind a gobally availabel load balancer solution.
This tutorial assumes that you have Azure, Git and Github basic knowledge.

## Steps
### 1. Create github repository.

### 2. Create the app.
`npx create-react-app {app name} --template typescript`

### 3. Push code to github repository.

### 4. Create azure resource group.
`az group create --location eastus2 --name {resource group name}`

### 5. Create azure static web app from ARM template.
- Go to folder .az/templates/stapp-create/ \
  `cd .az/templates/stapp-create`

- Open `parameters.json` file and populate repositoryToken.value property with your [repository token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

- Run az cli:\
  `az deployment group create \
  --name {static web app deployment group name} \
  --resource-group {resource group name} \
  --template-file 'template.json' \
  --parameters '@parameters.json'`

### 6. Create azure classic front door.
- Go to folder .az/templates/fd-create/ \
  `cd .az/templates/fd-create`

- Run az cli:\
  `az deployment group create \
  --name {front door deployment group name} \
  --resource-group {resource group name} \
  --template-file 'template.json' \
  --parameters '@parameters.json'`

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
