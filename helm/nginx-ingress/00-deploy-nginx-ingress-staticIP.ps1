# https://docs.microsoft.com/fr-fr/azure/aks/ingress-tls

# ----------------------------------------------------
# Create Public IP
# ----------------------------------------------------
Import-Module MESF_Azure -Force
Enable-MESF_AzureDebug

# Define required variables
$location          = "francecentral"
$resourceGroupName = "MC_AKS_aksCluster_francecentral"
$publicIpName      = "HunterGames_Services"
# It must conform to the following regular expression: ^[a-z][a-z0-9-]{1,61}[a-z0-9]$
$publicIpAlias     = "huntergames-services"

$publicIp = Set-MESFAzPublicIpAddress -ResourceGroupName $resourceGroupName `
                                      -Location $location `
                                      -Name $publicIpName `
                                      -DomainNameLabel $publicIpAlias


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

# Retrieve the ingress
kubectl get service -l app=nginx-ingress --namespace $namespace
