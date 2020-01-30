# common-omegnet-tools
Omegnet common tools for kubernetes

Before installing helm charts initialize terraform
```
./vsphere-set-env.sh c-tools.tfvars 
```
Then run:
```
terraform apply  --var-file=c-tools.tfvars
```
If you need to re-deploy helm chart, first taint it the re-apply:
```
terraform taint helm_release.metallb
terraform apply  --var-file=c-tools.tfvars
```
To remove specific resources with terraform
```
terraform destroy -target=helm_release.metallb -var-file=c-tools.tfvars
```
To delete all charts:
```
terraform destroy -var-file=terraform.tfvars
```



