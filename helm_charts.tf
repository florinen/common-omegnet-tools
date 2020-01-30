
data "helm_repository" "stable" {
    name = "stable"
    url  = "${var.private_url}"
    #url  = "${var.public_url}"
}

resource "helm_release" "metallb" {
    depends_on   = ["null_resource.helm_delete", "data.helm_repository.stable"]
    name         = "${var.metallb_name}"
    namespace    = "${var.metallb_namespace}"
    force_update = true
    repository   = data.helm_repository.stable.metadata[0].name
    chart        = "stable/${var.metallb_chart}"
    wait         = false
}
# values = [
#   "${file("configInline.yaml")}"
# ]
# set {
#     name = "configInline"
#     value = 
#   }

resource "helm_release" "ingress_controller" {
    depends_on   = ["null_resource.helm_delete", "data.helm_repository.stable"]
    name         = "${var.ingress_name}"
    namespace    = "${var.ingress_namespace}"
    force_update = true
    repository   = data.helm_repository.stable.name
    chart        = "stable/${var.ingress_chart}"
    wait         = false
    #version   = "${var.ingress_version}"
}
# set {
#     name = "consul-port"
#     value = "${var.consul_service_port}"
# }  
resource "helm_release" "nfs_client_provisioner" {
    depends_on   = ["null_resource.helm_delete", "data.helm_repository.stable"]
    name         = "${var.nfs_clinet_name}"
    namespace    = "${var.nfs_client_namespace}"
    force_update = true
    repository   = data.helm_repository.stable.name
    chart        = "stable/${var.nfs_client_chart}"
    wait         = false
    #version     = "${}"
}
resource "helm_release" "metrics_server" {
    depends_on = ["null_resource.helm_delete","data.helm_repository.stable"]
    name         = "${var.metrics_server_name}"
    namespace    = "${var.metrics_server_namespace}"
    force_update = true
    repository   = data.helm_repository.stable.name
    chart        = "stable/${var.metrics_server_chart}"
    wait         = false
    #version     = "${}"
}
