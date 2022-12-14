1. Install Azure CLI using installation [document](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
2. Install Terraform CLI using installation [document](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. Get Wallarm API token and put it in `helm-values/internal-ingress-values.yaml` file
4. Deploy Terraform code:
```
az login
cd terraform/azure
terraform init
terraform apply
```
5. Get cluster config
```
CLUSTER_NAME=$(terraform output -raw cluster_name)
echo "Cluster name: ${CLUSTER_NAME}"
RG_NAME=$(terraform output -raw rg_name)
echo "Resource group name: ${RG_NAME}"
az aks get-credentials --admin --name "${CLUSTER_NAME}" --resource-group "${RG_NAME}"
```
6. Perform test
```
LB_IP=$(kubectl get svc -l "app.kubernetes.io/component=controller" -n ingress-nginx -o=jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')
echo "Load Balancer IP: ${LB_IP}"
curl -H "Host: myapp.com" ${LB_IP}/get
curl -H "Host: myapp.com" ${LB_IP}/'?q=union+select+1'
``` 
Test is successfully done if last request get `403 Forbidden` response

7. Cleanup resources
```
terraform destroy
```