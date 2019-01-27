helm install  -n logging-base stable/elasticsearch  --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false


$POD_ELK=(kubectl get pods --namespace default -l "app=elasticsearch,component=client,release=logging-base" -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward --namespace default $POD_ELK 9200:9200

http://localhost:9200/_cluster/health?pretty


helm install -n kibana stable/kibana --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

$POD_KIBANA=(kubectl get pods --namespace default -l "app=kibana,release=kibana" -o jsonpath="{.items[0].metadata.name}")
    echo "Visit http://127.0.0.1:5601 to use Kibana"
    kubectl port-forward --namespace default $POD_KIBANA 5601:5601