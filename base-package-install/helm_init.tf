
## Untill terroform supports Helm_v3 this section will be disabled. Terraform can not deploy helm charts v3 yet!!
## To use terraform with Helm_v3 just uncomment below blocks
# provider "helm" {
#   version         = "~> 0.10"
#   service_account = "${var.helm_service_account_name}"
#   namespace       = "${var.helm_namespace}"
# }

# resource "null_resource" "helm" {
#   triggers = {
#     helm-config = "${sha1(file("${path.module}/templates/helm-rbac.yaml"))}"
#   }

#   provisioner "local-exec" {
#     command = <<EOF
#         kubectl create -f templates/helm-rbac.yaml 
#     EOF
#   }
# }
# resource "null_resource" "helm_delete" {
#   provisioner "local-exec" {
#     when    = "destroy"
#     command = <<EOF
#         kubectl delete -f  templates/helm-rbac.yaml
#     EOF
#   }
# }

## Terraform Helm_v2 charts ##

provider "helm" {
  version         = "~> 0.10" # Do not change to version 1.0
  tiller_image    = "gcr.io/kubernetes-helm/tiller:${var.tiller_version}"
  service_account = var.tiller_service_account_name
  install_tiller  = var.install_tiller
  namespace       = var.tiller_namespace
}

resource "null_resource" "helm" {
  triggers = {
    helm-config = "${sha1(file("./templates/helm-tiller.yaml"))}"
  }

  provisioner "local-exec" {
    command = <<EOF
        kubectl create -f templates/helm-tiller.yaml
        helm init --service-account=${var.tiller_service_account_name}
    EOF
  }
}
resource "null_resource" "helm_delete" {
  provisioner "local-exec" {
    when    = destroy
    interpreter = ["/bin/bash", "-c"]
    command = <<EOF
        cat templates/helm-tiller.yaml | kubectl delete -f -
        kubectl delete deployments  tiller-deploy -n ${var.tiller_namespace}
        kubectl delete services  tiller-deploy -n  ${var.tiller_namespace}
    EOF
    #on_failure = continue
  } 
}








