## AWS S3 Bucket ##

data "terraform_remote_state" "base_config" {
  backend = "s3"

  config = {
    bucket  = "kube.omegnet.com"
    key     = "vsphere/prod/base-tools/base-tools.tfstate"
    key    = "${var.provider_name}/${var.deployment_environment}/${var.deployment}/${var.state_file}"
    region  = "${var.region}"
  }
}

## Consul ##

# data "terraform_remote_state" "base_config" {
#   backend = "consul"

#   config = {
#     address = "consul.omegnet.com"
#     scheme  = "http"
#     path    = "${var.provider_name}/${var.deployment_environment}/${var.state_file_name}"
#   }
# }