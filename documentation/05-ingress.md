# Configure ingress

## Resources
1. https://docs.microsoft.com/fr-fr/azure/aks/ingress-static-ip
2. https://docs.microsoft.com/fr-fr/azure/aks/ingress-tls

## Define a Public IP for the application
This public Ip will be use to access to the cluster.  

### Create a Public IP for the application in Azure
This sample is based on HunterGames application. To have more information on how manage public ip, go to [ygo74 repository azure](https://github.com/ygo74/azure).  

```powershell
# ----------------------------------------------------
# Create Public IP
# ----------------------------------------------------
Import-Module MESF_Azure -Force
Enable-MESF_AzureDebug

# Define required variables
$location          = "francecentral"
$resourceGroupName = "MC_AKS_aksCluster_francecentral"
$publicIpName      = "HunterGames_Services" 
$publicIpAlias     = "huntergames-services"

Set-MESFAzPublicIpAddress -ResourceGroupName $resourceGroupName `
                          -Location $location `
                          -Name $publicIpName `
                          -DomainNameLabel $publicIpAlias

```

## Deploy the nginx-ingress bound on the public ip

```powershell
# Create a namespace for the application
# DNS-1123 label must consist of lower case alphanumeric characters or '-', and must start and
# end with an alphanumeric character (e.g. 'my-name',  or '123-abc', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?')
$namespace = "hunter-games"
$releaseName = "$namespace-ingress"
kubectl create namespace $namespace

# Install the ingress for application
helm install stable/nginx-ingress `
    --namespace $namespace `
    --name $releaseName `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set controller.service.loadBalancerIP="$($publicIp.IpAddress)"
```
