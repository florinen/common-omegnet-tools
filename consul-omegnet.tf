provider "helm" {
  version        = "~> 0.9"
  install_tiller = true
}
module "tiller" {
  source  = "github.com/sagikazarmark/terraform-tiller"
  #version = "~> 0.1.0"
}
resource "helm_release" "consul" {
    name      = "${var.consul_name}"
    namespace = "${var.namespace}"
    chart     = "${path.module}/consul"
}
# set {
#     name = "consul-port"
#     value = "${var.consul_service_port}"
#   }