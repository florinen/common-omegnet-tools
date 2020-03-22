
# Base package install. This must be installed first
# Base package install
## Charts in here are required as the minimum after cluster creation.
## - this must be deleted after everything else was removed first (other helm releases)

Omegnet common tools for kubernetes Base package instalation. This will install helm charts. 

Before installing helm charts initialize terraform
```
source ./vsphere-set-env.sh ../../data/base-tools.tfvars 
```
Then run:
```
terraform apply  --var-file $DATAFILE 
```
If you need to re-deploy helm chart, first taint it, then re-apply:

Ex:
```
terraform taint helm_release.metallb
terraform apply  --var-file $DATAFILE 
```
To remove specific resources with terraform
```
terraform destroy -target=helm_release.metallb -var-file $DATAFILE 
```
To delete all charts:
```
terraform destroy -var-file $DATAFILE 
```



