# https://docs.microsoft.com/fr-fr/azure/aks/ingress-tls

kubectl create namespace ingress-basic

helm install stable/nginx-ingress `
    --namespace ingress-basic `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

kubectl get service -l app=nginx-ingress --namespace ingress-basic

# Configure DNS
$IP = "20.188.47.246"
$DNSNAME="mesf-aks-ingress"
$PUBLICIPID = az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME

# https://docs.microsoft.com/fr-fr/azure/aks/ingress-static-ip

#Todo retrieve PublicIP
```powershell


    `
    --set controller.service.loadBalancerIP="40.121.63.72"


# get service ingress
kubectl get service -l app=nginx-ingress --namespace ingress-basic



$publicIp = (Get-AzureRmPublicIpAddress -Name jenkins-aks -ResourceGroupName MC_AKS_aksCluster_westeurope | Select-Object -ExpandProperty IpAddress)

helm install  -n global-proxy stable/nginx-ingress `
              --namespace kube-system `
              --set controller.replicaCount=2

              `
              --set controller.service.loadBalancerIP="$publicIp" `
              --set rbac.create=false `
              --set rbac.createRole=false `
              --set rbac.createClusterRole=false

helm upgrade global-proxy stable/nginx-ingress --namespace kube-system  --set controller.replicaCount=2 --set controller.service.loadBalancerIP="$publicIp" --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

kubectl --namespace kube-system get services -o wide -w global-proxy-nginx-ingress-controller

```