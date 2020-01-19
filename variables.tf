

### Backend use ###
variable "provider_name" {}
variable "deployment_environment" {}
variable "deployment_name" {}
variable "tiller_name" {}


## Deployments 

variable "private_url" {}
variable "public_url" {}



# Tiller
variable "tiller_namespace" {}
variable "tiller_version" {}
variable "install_tiller" {}
variable "tiller_name" {}

## MetalLB
variable "metallb_namespace" {}
variable "metallb_name" {}
variable "metallb_chart" {}





variable "namespace" {
    description = "default namespace for all apps"
    default = "apps" 
}
variable "label" {
  default = "consul"
}

variable    "jenkins_service_port"     {
  default = 8090
  description = "Please do not change this ports."
}
variable    "grafana_service_port"        {
  default = 8091
  description = "Please do not change this ports."
}

variable    "nexus_service_port"       {
  default = 8092
  description = "Please do not change this ports."
}

variable    "vault_service_port"       {
  default = 8093
  description = "Please do not change this ports."
}
variable    "consul_service_port"       {
  default = 8094
  description = "Please do not change this ports."
}

variable "consul_name" {
  default = "consul"
}
