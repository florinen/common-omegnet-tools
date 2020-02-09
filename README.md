# common-omegnet-tools
#  Prerequisite: 
# - Base Package install must be deployed first as this will need to install necessary tools all other charts depend on.

Omegnet common tools for kubernetes. This will install helm charts. 

Before installing helm charts initialize terraform
```
source ./vsphere-set-env.sh c-tools.tfvars 
```
Then run:
```
terraform apply  --var-file $DATAFILE 
```
If you need to re-deploy helm chart, first taint it, then re-apply:
```
terraform taint helm_release.metrics_server
terraform apply  --var-file $DATAFILE 
```
To remove specific resources with terraform
```
terraform destroy -target=helm_release.metrics_server -var-file $DATAFILE 
```
To delete all charts:
```
terraform destroy -var-file $DATAFILE 
```



