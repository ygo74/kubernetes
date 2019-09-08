# kubernetes

## Table of Contents
1. [Prerequisites](documentation/00-prerequisites.md)
2. [Installation](documentation/01-installation.md)
3. [Configuration](documentation/02-configuration.md)
4. [Basic commands](documentation/03-basic-commands.md)
4. [Helm commands](documentation/04-helm-commands.md)

## Kubernetes On Azure
### Prerequisites  

Version as is in 17/11/2018 : 2.0.50

**Install az cli**  
* For Windows : [Download latest version](https://aka.ms/installazurecliwindows)  

* For Ubuntu  : [Documentation Source](https://docs.microsoft.com/fr-fr/cli/azure/install-azure-cli-apt?view=azure-cli-latest)  
```bash
sudo apt-get install apt-transport-https lsb-release software-properties-common -y
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF

sudo apt-get update
sudo apt-get install azure-cli
```
**Install Kubernetes client and link it to az cli**  
`az aks install-cli`

## Cluster configuration

list of clusters : C:\Users\Administrator\.kube\config  

## Common Kubernetes Usage

az aks show --resource-group $ResourceGroupName --name $aksClusterName --query nodeResourceGroup -o tsv
az network public-ip show --resource-group MC_AKS_aksCluster_westeurope --name jenkins-aks --query ipAddress

* ***Check ingress service***

```
kubectl get svc ingress-nginx -n ingress-nginx -o=jsonpath="{.status.loadBalancer.ingress[0].ip}
```
