

resource "helm_release" "jenkins" {
  depends_on   = [null_resource.helm_delete, data.helm_repository.bitnami, helm_release.nfs_client_provisioner]
  name         = var.jenkins_name
  namespace    = var.jenkins_namespace
  force_update = true
  repository   = data.helm_repository.bitnami.metadata[0].name
  chart        = "bitnami/${var.jenkins_chart}"
  wait         = false
  # values = [
  #   "${file("~/omegnet.com/kubernetes/charts/bitnami/jenkins/values.yaml")}"
  # ]
  set {
    name  = "image.registry"
    value = "docker.io"
  }
  set {
    name  = "image.repository"
    value = "bitnami/jenkins"
  }
  set_string {
    name  = "image.tag"
    value = "2.222.1-debian-10-r2"
  }
  set {
    name  = "jenkinsUser"
    value = "user"   
  }
  set {
    name  = "jenkinsHome"
    value = "/opt/bitnami/jenkins/jenkins_home"
  }
  set_string {
    name  = "resources.requests.cpu"
    value = "200m"   
  }
  set_string {
    name  = "resources.requests.memory"
    value = "1Gi"   
  }
set {
    name  = "persistence.storageClass"
    value = "nfs-client"
  }
  set {
    name  = "persistence.annotations.kubernetes\\.io/storage-class\\.class"
    value = "nfs-client"
  }
  set {
    name  = "persistence.accessModes"
    value = "{ReadWriteMany}"
  }
  set_string {
    name  = "persistence.size"
    value = "5Gi"
  }
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  set {
    name  = "ingress.certManager"
    value = "false"
  }
  set {
    name  = "ingress.hostname"
    value = "jenkins-qa.varu.local"
  }
}
