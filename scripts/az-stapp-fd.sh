# Login to Azure
az login

# Variables
resourcesLocation=eastus2
resourceGroupName=rg-demo-prod--001

# Static web app variables
appName=stapp-demo-prod-eastus2-001
repoPath={GITHUB REPOSITORY PATH}
branchName=main
personalToken={GITHUB PERSONAL ACCESS TOKEN}

# Frontdoor variables
frontDoorName=fd-demo-prod-001

# Create resource group
az group create \
	--name $resourceGroupName \
	--location $resourcesLocation

# Create static web app
az staticwebapp create \
	-n $appName \
	-s $repoPath \
	-b $branchName \
	-l $resourcesLocation \
	-g $resourceGroupName \
	-t $personalToken \
	--sku Standard

# Get static web app url and remove double quotes from string
stappDefaulHostName=$(az staticwebapp show -n $appName -g $resourceGroupName --query "defaultHostname" | tr -d '"')

# Create front door
az network front-door create \
	--name $frontDoorName \
	--resource-group $resourceGroupName \
	--accepted-protocols Http Https \
	--backend-address $stappDefaulHostName
