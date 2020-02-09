data "helm_repository" "stable" {
  name = "stable"
  url  = "${var.private_url}"
  #url  = "${var.public_url}"
}
# resource "helm_release" "metallb" {
#   depends_on   = ["null_resource.helm_delete", "data.helm_repository.stable"]
#   name         = "${var.metallb_name}"
#   namespace    = "${var.metallb_namespace}"
#   force_update = true
#   repository   = data.helm_repository.stable.metadata[0].name
#   chart        = "stable/${var.metallb_chart}"
#   wait         = false
# }
# resource "helm_release" "ingress_controller" {
#   depends_on   = ["null_resource.helm_delete", "data.helm_repository.stable", "helm_release.metallb"]
#   name         = "${var.ingress_name}"
#   namespace    = "${var.ingress_namespace}"
#   force_update = true
#   repository   = data.helm_repository.stable.name
#   chart        = "stable/${var.ingress_chart}"
#   wait         = false
#   #version   = "${var.ingress_version}"
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

  values = [
    "${file("values.yaml")}"
  ]
  set_string {
    name  = "nfs.path"
    value = "/mnt/Storage/Kube-data/dev"
  }
}
resource "helm_release" "consul" {
  depends_on   = ["null_resource.helm_delete", "data.helm_repository.stable", "helm_release.nfs_client_provisioner"]
  name         = "${var.consul_name}"
  namespace    = "${var.consul_namespace}"
  force_update = true
  repository   = data.helm_repository.stable.metadata[0].name
  chart        = "stable/${var.consul_chart}"
  wait         = false
}
