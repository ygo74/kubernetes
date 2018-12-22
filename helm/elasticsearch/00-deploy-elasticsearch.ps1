helm install  -n logging-base stable/elasticsearch  --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false


$POD_ELK=(kubectl get pods --namespace default -l "app=elasticsearch,component=client,release=logging-base" -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward --namespace default $POD_ELK 9200:9200