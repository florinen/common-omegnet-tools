
### Backend use ###
variable "provider_name" {}
variable "deployment_environment" {}
variable "deployment_name" {}
variable "state_file_name" {}
variable "deployment" {}
variable "state_file" {}

# S3
variable "backend" {}
variable "bucket" {}
variable "region" {}




## Deployments 

variable "vsphere_cluster" {}
variable "local_domain" {}
variable "envinroment" {}



variable "private_url" {}
variable "public_url" {}



# Tiller
variable "tiller_namespace" {}
variable "tiller_version" {}
variable "install_tiller" {}
variable "tiller_name" {}
variable "tiller_service_account_name" {}


# Helm_v3
variable "helm_service_account_name" {}
variable "helm_namespace" {}
variable "helm_version" {}



## MetalLB
variable "metallb_namespace" {}
variable "metallb_name" {}
variable "metallb_chart" {}

## Ingress Controller

variable "ingress_namespace" {}
variable "ingress_name" {}
variable "ingress_chart" {}
variable "ingress_version" {}

## NFS Clien Provisioner
variable "nfs_clinet_name" {}
variable "nfs_client_namespace" {}
variable "nfs_client_chart" {}

## Metric Server
variable "metrics_server_name" {}
variable "metrics_server_namespace" {}
variable "metrics_server_chart" {}

## Prometheus
variable "prometheus_name" {}
variable "prometheus_namespace" {}
variable "prometheus_chart" {}

## Consul
variable "consul_name" {}
variable "consul_namespace" {}
variable "consul_chart" {}











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


