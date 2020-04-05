# Kubernetes configuration

## Helm

### Installing Helm
* Download Windosws 10 package : [Github release](https://github.com/helm/helm/releases)  
* Unzip and add to system path

```powershell
mklink /D d:\devel\Tools\kubernetes\helm d:\devel\Tools\kubernetes\helm-2.14.3\windows-amd64
```

#### Install tiller in standard Kubernetes :   
```powershell
helm init
```

#### Install tiller in AKS :   
Reference : https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm  

```powershell
helm init --upgrade --service-account default
```

### Configuration

#### Manual configuration
1. Create service Account tiller
```yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system

```




2. Bind service account tiller to cluster-admin role
```yaml
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system

```

#### Use following commands to apply the tiller configuration

```powershell
cd D:\devel\github\devops-toolbox\containers\kubernetes

#  Create tiller account and bind it to cluster-admin role
kubectl apply -f .\configuration\helm\01-helm-rbac.yaml
helm init --service-account tiller --upgrade
helm repo update

```

## Certificates Manager
Goal : Generate certificates for Kubernetes services  
Provider : JetStack ([Site web](https://www.jetstack.io))  
Certificates authorities : letsencrypt ([Site web](https://letsencrypt.org/fr/))  
Get Started : http://docs.cert-manager.io/en/latest/  

### Installation cert-manager
```powershell
# Install the CustomResourceDefinition resources separately
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install `
  --name cert-manager `
  --namespace cert-manager `
  --version v0.8.0 `
  jetstack/cert-manager
```

### Create Issuer

Lets Encrypt Issuer servers :  
1. Staging : https://acme-staging-v02.api.letsencrypt.org/directory
2. Prod :  https://acme-v02.api.letsencrypt.org/directory

```yaml
# Issuer for staging
apiVersion: certmanager.k8s.io/v1alpha1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
  namespace: ingress-basic
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: myemail@mydomain.com
    privateKeySecretRef:
      name: letsencrypt-staging
    http01: {}
```
### Use following scripts to deploy
```powershell
cd D:\devel\github\devops-toolbox\containers\kubernetes

# Deploy cert manager
& .\configuration\cert-manager\01-install-cert-manager.ps1
kubectl apply -f .\configuration\cert-manager\02-cluster-issuer.yaml

```
