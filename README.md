# kubernetes

## Kubernetes On Azure
### Prerequisites  

Version as is in 17/11/2018 : 2.0.50

**Install az cli**  
* For Windows : [Download latester version](https://aka.ms/installazurecliwindows)  

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

### Create Cluster AKS
Repository : [ygo74/azure](https://github.com/ygo74/azure)  
Scripts    : [01-ContinuousIntegration](https://github.com/ygo74/azure/tree/master/scripts/01-ContinuousIntegration)  

### Connect to the cluster  
```powershell
$aksClusterName    = "aksCluster"
$ResourceGroupName = "AKS"
az aks get-credentials --resource-group $ResourceGroupName  --name $aksClusterName  
  
az aks browse -g $ResourceGroupName -n $aksClusterName
```  

## Common Kubernetes Usage
* ***View Kubectl configuration***  
```
kubectl config view
```  

* ***Retrieve list of cluster's nodes***  
```
kubectl get nodes
```  

* ***Browse Kubernetes Cluster***  
```
kubectl proxy
```  


az aks show --resource-group $ResourceGroupName --name $aksClusterName --query nodeResourceGroup -o tsv
az network public-ip show --resource-group MC_AKS_aksCluster_westeurope --name jenkins-aks --query ipAddress