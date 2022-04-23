# Azure Static Web App + Azure Classic Frontdoor.
This tutorial is meant to help you to create an Azure based application behind a gobally availabel load balancer solution.
This tutorial assumes that you have Azure, Git and Github basic knowledge.

## Steps
1. Create github repository.
3. Create react app using (for this tutorial we used npx `create-react-app {app name} --template typescript`).
4. Push code to github repository.
5. Create azure resource group.
6. Create azure static web app.
7. Create azure classic front door.
8. Create staticwebapp.config.json file on repository root folder.
9. Add static web app config networking node:
\
   `"networking": { "allowedIpRanges": ["AzureFrontDoor.Backend"] }`

9. Add static web app config forwardingGateway node:
`
  "forwardingGateway": {
    "requiredHeaders": {
      "X-Azure-FDID": "8833fd05-b47c-4659-b280-61951f8c5b2e"
    },
    "allowedForwardedHosts": ["fd-demo-prod-001.azurefd.net"]
  }
`

## Help links:
- [Reference tutorial.](https://docs.microsoft.com/en-us/azure/static-web-apps/front-door-manual)
- [Azure resources naming convention.](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Azure resources abbreviations.](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).
