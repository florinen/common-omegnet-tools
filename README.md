# common-omegnet-tools
Omegnet common tools for kubernetes

Before installing helm charts initialize terraform
```
source ./vsphere-set-env.sh ../data/c-tools.tfvars 
```
Then run:
```
terraform apply  --var-file $DATAFILE 
```
If you need to re-deploy helm chart, first taint it the re-apply:
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



