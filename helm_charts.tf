
data "helm_repository" "stable" {
  depends_on = ["null_resource.helminit"]
  name       = "stable"
  #url  = "${var.public_url}"
  url        = "${var.private_url}"
}

resource "helm_release" "metallb" {
  depends_on = ["data.helm_repository.stable"]
  name       = "metallb"
  namespace  = "metallb-system"
  force_update = true
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "${path.module}/${var.metallb_chart}"
  wait       = false
  
  # values = [
  #   "${file("configInline.yaml")}"
  # ]
  # set {
  #     name = "configInline"
  #     value = 
  #   }
}
# resource "helm_release" "consul" {
#     name      = "${var.consul_name}"
#     namespace = "${var.namespace}"
#     chart     = "${path.module}/consul"
# }
# set {
#     name = "consul-port"
#     value = "${var.consul_service_port}"
#   }
