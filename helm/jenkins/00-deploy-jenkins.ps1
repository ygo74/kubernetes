
#Web site : https://github.com/helm/charts/tree/master/stable/jenkins
helm install stable/jenkins --namespace default --set controller.replicaCount=2 --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false -n jenkins

$password = (kubectl get secret --namespace default jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode)
write-host "passsword : $password"

$SERVICE_IP= (kubectl get svc --namespace default jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
write-host "uri : http://$($SERVICE_IP):8080/login"