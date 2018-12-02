

helm install stable/rabbitmq-ha -n messaging --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

helm upgrade messaging stable/rabbitmq-ha --set ingress.enabled=true --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

helm upgrade messaging stable/rabbitmq-ha --set ingress.path=/messaging --set ingress.enabled=true --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false





$password = (kubectl get secret --namespace default messaging-rabbitmq-ha -o jsonpath="{.data.rabbitmq-password}" | base64 --decode)
Write-Output $password

$POD_NAME = (kubectl get pods --namespace default -l "app=rabbitmq-ha" -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward $POD_NAME --namespace default 5672:5672 15672:15672


** Please be patient while the chart is being deployed **

  Credentials:

    Username      : guest
    Password      : $(kubectl get secret --namespace default messaging-rabbitmq-ha -o jsonpath="{.data.rabbitmq-password}" | base64 --decode)
    ErLang Cookie : $(kubectl get secret --namespace default messaging-rabbitmq-ha -o jsonpath="{.data.rabbitmq-erlang-cookie}" | base64 --decode)


  RabbitMQ can be accessed within the cluster on port 5672 at messaging-rabbitmq-ha.default.svc.cluster.local

  To access the cluster externally execute the following commands:

    export POD_NAME=$(kubectl get pods --namespace default -l "app=rabbitmq-ha" -o jsonpath="{.items[0].metadata.name}")
    kubectl port-forward $POD_NAME --namespace default 5672:5672 15672:15672

  To Access the RabbitMQ AMQP port:

    amqp://127.0.0.1:5672/

  To Access the RabbitMQ Management interface:

    URL : http://127.0.0.1:15672
