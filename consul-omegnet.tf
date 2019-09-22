resource "helm_release" "omegnet_services_ingress" {
    name      = "consul-omegnet-service-${var.namespace}"
    namespace = "${var.namespace}"
    chart     = "${path.module}/consul"
}
set {
    name = "consul-port"
    value = "${var.consul_service_port}"
  }