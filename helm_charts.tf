
data "helm_repository" "stable" {
  name = "stable"
  url  = "${var.private_url}"
  #url  = "${var.public_url}"
}

resource "helm_release" "metrics_server" {
    depends_on   = ["null_resource.helm_destroy","data.helm_repository.stable"]
    name         = "${var.metrics_server_name}"
    namespace    = "${var.metrics_server_namespace}"
    force_update = true
    repository   = data.helm_repository.stable.name
    chart        = "stable/${var.metrics_server_chart}"
    wait         = false
    #version     = "${}"
  
}
resource "helm_release" "prometheus" {
    depends_on   = ["null_resource.helm_destroy","data.helm_repository.stable"]
    name         = "${var.prometheus_name}"
    namespace    = "${var.prometheus_namespace}"
    force_update = true
    repository   = data.helm_repository.stable.name
    chart        = "stable/${var.prometheus_chart}"
    wait         = false
    #version     = "${}"

}
resource "null_resource" "helm_destroy" {
    provisioner "local-exec" {
    when = "destroy"

    command = <<EOF
      helm delete --purge ${var.metrics_server_name} ${var.prometheus_name} --tiller-namespace ${var.tiller_namespace}
      true
    EOF
  }
}

## Delete all Helm Charts ##

# resource "null_resource" "helm_destroy" {
#     provisioner "local-exec" {
#     when = "destroy"

#     command = <<EOF
#       for i in $(helm list | awk '{print $1}' |grep -v NAME); do helm delete --purge $i --tiller-namespace ${var.tiller_namespace}
#       true
#     EOF
#   }
# }

