data "helm_repository" "stable" {
  name = "stable"
  url  = "${var.private_url}"
  #url  = "${var.public_url}"
}
data "helm_repository" "bitnami" {
  name = "bitnami"
  #url  = "${var.private_url}"
  url = "${var.public_url}"
}
resource "helm_release" "metallb" {
  depends_on   = [null_resource.helm_delete, data.helm_repository.stable]
  name         = var.metallb_name
  namespace    = var.metallb_namespace
  force_update = true
  repository   = data.helm_repository.stable.metadata[0].name
  chart        = "stable/${var.metallb_chart}"
  wait         = false

  set_string {
    name  = "configInline.config"
    value = <<EOF
    address-pools:
    - name: my-ip-space
      protocol: layer2
      addresses:
      - 10.10.45.240-10.10.45.248 
    EOF
  }
}

resource "helm_release" "ingress_controller" {
  depends_on   = [null_resource.helm_delete, data.helm_repository.stable, helm_release.metallb]
  name         = var.ingress_name
  namespace    = var.ingress_namespace
  force_update = true
  repository   = data.helm_repository.stable.name
  chart        = "stable/${var.ingress_chart}"
  wait         = false
  version      = var.ingress_chart_version

  set_string {
    name  = "controller.image.tag"
    value = "0.26.2"
  }

}

resource "helm_release" "nfs_client_provisioner" {
  depends_on   = [null_resource.helm_delete, data.helm_repository.stable]
  name         = var.nfs_clinet_name
  namespace    = var.nfs_client_namespace
  force_update = true
  repository   = data.helm_repository.stable.name
  chart        = "stable/${var.nfs_client_chart}"
  wait         = false
  #version     = "${}"

  #   values = [
  #     "${file("./nfs-client-provisioner/values.yaml")}"
  #   ]
  set_string {
    name  = "nfs.path"
    value = "/mnt/Storage/Kube-data/qa" # @
  }
}

resource "helm_release" "consul" {
  depends_on   = [null_resource.helm_delete, data.helm_repository.stable, helm_release.nfs_client_provisioner]
  name         = var.consul_name
  namespace    = var.consul_namespace
  force_update = true
  repository   = data.helm_repository.stable.metadata[0].name
  chart        = "stable/${var.consul_chart}"
  wait         = false

  set_string {
    name  = "uiIngress.hosts.host.name"
    value = "qa-consul.varu.local" # @
  }
}
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
    value = "qa-jenkins.varu.local"
  }
}
