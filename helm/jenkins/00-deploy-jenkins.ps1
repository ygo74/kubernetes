
#Web site : https://github.com/helm/charts/tree/master/stable/jenkins
```powershell
cd D:\devel\github\devops-toolbox\containers\kubernetes\helm\jenkins
helm install stable/jenkins -n jenkins --namespace default -f values.yml --set ingress.enabled=true --set controller.replicaCount=2 --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

helm upgrade jenkins stable/jenkins -f values.yml --set ingress.enabled=true --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false

```


## Get Deployment status
```powershell
kubectl get svc --namespace default -w jenkins


$password = (kubectl get secret --namespace default jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode)
write-host "passsword : $password"

$SERVICE_IP= (kubectl get svc --namespace default jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
write-host "uri : http://$($SERVICE_IP):8080/login"

```