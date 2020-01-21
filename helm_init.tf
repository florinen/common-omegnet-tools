# provider "helm" {
#   version         = "~> 0.10"
#   tiller_image    = "gcr.io/kubernetes-helm/tiller:${var.tiller_version}"
#   install_tiller  = "${var.install_tiller}"
#   service_account = "tiller"
#   namespace       = "${var.tiller_namespace}"
# }
# resource "kubernetes_service_account" "tiller" {
  
#   metadata {
#     name      = "${var.tiller_name}"
#     namespace = "${var.tiller_namespace}"
#   }
#   automount_service_account_token = true
# }
# resource "kubernetes_cluster_role_binding" "tiller" {
#   depends_on = ["kubernetes_service_account.tiller"]

#   metadata {
#     name = "${var.tiller_name}"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }
#   subject {
#     kind      = "User"
#     name      = "admin"
#     api_group = "rbac.authorization.k8s.io"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = "${var.tiller_name}"
#     namespace = "${var.tiller_namespace}"
#   }
#   subject {
#     kind      = "Group"
#     name      = "system:masters"
#     api_group = "rbac.authorization.k8s.io"
#   }
# }
# resource "null_resource" "helminit" {
#   depends_on = ["kubernetes_cluster_role_binding.tiller"]
#   provisioner "local-exec" {
#     command = "helm init --service-account=tiller"
#   }
# }
# resource "null_resource" "helm_delete" {
#   provisioner "local-exec" {
#     when    = "destroy"
#     command = "kubectl delete deployments -n ${var.tiller_namespace} tiller-deploy"
#   }
# }

resource "kubernetes_service_account" "tiller" {
  metadata {
    name = "${var.tiller_name}"
    namespace = "${var.tiller_namespace}"
  }
  automount_service_account_token = true
}
resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
        name = "${var.tiller_name}"
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "system:serviceaccount:${var.tiller_namespace}:${var.tiller_name}"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind  = "ClusterRole"
    name = "cluster-admin"
  }
  depends_on = ["kubernetes_service_account.tiller"]
}
resource "null_resource" "helminit" {
  provisioner "local-exec" {
    command = "helm init --service-account=${var.tiller_name}"
  }
  depends_on = ["kubernetes_cluster_role_binding.tiller"]
}
resource "null_resource" "helm_delete" {
  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete deployments -n ${var.tiller_namespace} tiller-deploy"
  }
}




