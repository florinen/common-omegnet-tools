provider "helm" {
  version         = "~> 0.10"
  tiller_image    = "gcr.io/kubernetes-helm/tiller:${var.tiller_version}"
  install_tiller  = true
  service_account = "tiller"
  namespace       = "kube-system"
}
resource "kubernetes_service_account" "tiller" {
  
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
  automount_service_account_token = true
}
resource "kubernetes_cluster_role_binding" "tiller" {
  depends_on = ["kubernetes_service_account.tiller"]

  metadata {
    name = "tiller"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "admin"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
  }
  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
}
resource "null_resource" "helminit" {
  depends_on = ["kubernetes_cluster_role_binding.tiller"]
  provisioner "local-exec" {
    command = "helm init --service-account=tiller"
  }
}
resource "null_resource" "helm_delete" {
  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete deployments -n kube-system tiller-deploy"
  }
}






