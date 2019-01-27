
#Todo retrieve PublicIP
```powershell

$publicIp = (Get-AzureRmPublicIpAddress -Name jenkins-aks -ResourceGroupName MC_AKS_aksCluster_westeurope | Select-Object -ExpandProperty IpAddress)

helm install  -n global-proxy stable/nginx-ingress --namespace kube-system  --set controller.replicaCount=2 --set controller.service.loadBalancerIP="$publicIp" --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false
helm upgrade global-proxy stable/nginx-ingress --namespace kube-system  --set controller.replicaCount=2 --set controller.service.loadBalancerIP="$publicIp" --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

kubectl --namespace kube-system get services -o wide -w global-proxy-nginx-ingress-controller

```