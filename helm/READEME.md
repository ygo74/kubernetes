# Helm

## Installing Helm
* Download Windosws 10 package : [Github release](https://github.com/helm/helm/releases)  
* Unzip and to system path

### Install tiller in standard Kubernetes :   
`helm init`  

### Install tiller in AKS :   
```powershell
helm init --upgrade --service-account default
```





## Commmon usages
* Add repo  
__helm repo add [repository name] [repo url]__  

repositories




