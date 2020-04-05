# https://docs.microsoft.com/fr-fr/azure/aks/ingress-tls

# Create a namespace for the application
# DNS-1123 label must consist of lower case alphanumeric characters or '-', and must start and
# end with an alphanumeric character (e.g. 'my-name',  or '123-abc', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?')
$namespace = "ingress-basic"
kubectl create namespace $namespace

# Install the ingress for application
# a Public IP will be created (how ????) and will have the lifecycle of the created controller
helm install stable/nginx-ingress `
    --namespace $namespace `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

# Retrieve the public IP assigned to the ingress
kubectl get service -l app=nginx-ingress --namespace $namespace

#Copy public ip in the variables
$IP = "20.188.47.246"
$PUBLICIPID = az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv

# Configure DNS
$DNSNAME="mesf-aks-ingress"
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME
