
#Todo retrieve PublicIP
helm install  -n global-proxy stable/nginx-ingress --namespace kube-system  --set controller.replicaCount=2 --set controller.service.loadBalancerIP="23.97.129.10" --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

kubectl --namespace kube-system get services -o wide -w global-proxy-nginx-ingress-controller