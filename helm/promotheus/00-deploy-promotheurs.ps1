
helm install  -n promotheus-base stable/prometheus `
      --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false



$POD_NAME = (kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 9093