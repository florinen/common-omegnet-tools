resource "helm_release" "omegnet_services_ingress" {
    name      = "nexus-omegnet-service-${var.namespace}"
    namespace = "${var.namespace}"
    chart     = "${path.module}/nexus"
}
set {
    name = "nexus-port"
    value = "${var.nexus_service_port}"
  }