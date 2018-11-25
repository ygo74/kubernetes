

helm install stable/rabbitmq-ha -n messaging --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

helm upgrade messaging stable/rabbitmq-ha --set ingress.enabled=true --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

helm upgrade messaging stable/rabbitmq-ha --set ingress.path=/messaging --set ingress.enabled=true --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false





$password = (kubectl get secret --namespace default messaging-rabbitmq-ha -o jsonpath="{.data.rabbitmq-password}" | base64 --decode)
Write-Output $password

$POD_NAME = (kubectl get pods --namespace default -l "app=rabbitmq-ha" -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward $POD_NAME --namespace default 5672:5672 15672:15672
