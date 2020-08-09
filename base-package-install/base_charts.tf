data "helm_repository" "omegnet" {
  name = "omegnet"
  url  = "${var.private_url}"
  #url  = "${var.public_url}"
}
resource "helm_release" "metallb" {
  depends_on   = ["null_resource.helm_delete", "data.helm_repository.omegnet"]
  name         = "${var.metallb_name}"
  namespace    = "${var.metallb_namespace}"
  force_update = true
  repository   = data.helm_repository.omegnet.name
  chart        = "${var.metallb_chart}"
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
  depends_on   = ["null_resource.helm_delete", "data.helm_repository.omegnet", "helm_release.metallb"]
  name         = "${var.ingress_name}"
  namespace    = "${var.ingress_namespace}"
  force_update = true
  repository   = data.helm_repository.omegnet.name
  chart        = "${var.ingress_chart}"
  wait         = false
  version   = "${var.ingress_chart_version}"

  set_string {
    name  = "controller.image.tag"
    value = "0.26.2"
  }
  
}

resource "helm_release" "nfs_client_provisioner" {
  depends_on   = ["null_resource.helm_delete", "data.helm_repository.omegnet"]
  name         = "${var.nfs_clinet_name}"
  namespace    = "${var.nfs_client_namespace}"
  force_update = true
  repository   = data.helm_repository.omegnet.name
  chart        = "${var.nfs_client_chart}"
  wait         = false
  #version     = "${}"

#   values = [
#     "${file("./nfs-client-provisioner/values.yaml")}"
#   ]
  set_string {
    name  = "nfs.path"
    value = "/mnt/Storage/Kube-data/dev"
  }
}

resource "helm_release" "consul" {
  depends_on   = ["null_resource.helm_delete", "data.helm_repository.omegnet", "helm_release.nfs_client_provisioner"]
  name         = "${var.consul_name}"
  namespace    = "${var.consul_namespace}"
  force_update = true
  repository   = data.helm_repository.omegnet.name
  chart        = "${var.consul_chart}"
  wait         = false

  set_string {
    name  = "uiIngress.hosts.host.name"
    value = "dev-consul.varu.local"
  }
}
