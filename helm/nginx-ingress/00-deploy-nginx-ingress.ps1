helm install stable/nginx-ingress --namespace kube-system --set controller.replicaCount=2 --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false -n global-proxy

kubectl --namespace kube-system get services -o wide -w global-proxy-nginx-ingress-controller