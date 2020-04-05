
data "helm_repository" "stable" {
  name = "stable"
  url  = "${var.private_url}"
  #url  = "${var.public_url}"
}

resource "helm_release" "metrics_server" {
  depends_on   = [null_resource.helm_destroy, data.helm_repository.stable]
  name         = var.metrics_server_name
  namespace    = var.metrics_server_namespace
  force_update = true
  repository   = data.helm_repository.stable.name
  chart        = "stable/${var.metrics_server_chart}"
  wait         = false
  #version     = "${}"

  set {
    name  = "rbac.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.create"
    value = "true"
  }
  set_string {
    name  = "image.tag"
    value = "v0.3.6"
  }
  # set_string {
  #   name  = "args"
  #   value = <<EOF
  #   - --kubelet-insecure-tls
  #   - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname,
  #   - --v=2
  #   EOF
  # }

}
resource "helm_release" "prometheus" {
  depends_on   = [null_resource.helm_destroy, data.helm_repository.stable]
  name         = var.prometheus_name
  namespace    = var.prometheus_namespace
  force_update = true
  repository   = data.helm_repository.stable.name
  chart        = "stable/${var.prometheus_chart}"
  wait         = false
  #version     = "${}"

## Alertmanager ##
  set_string {
    name  = "alertmanager.image.tag"
    value = "v0.20.0"
  }
  set {
    name  = "alertmanager.ingress.enabled"
    value = "true"
  }
  set {
    name  = "alertmanager.annotations.kubernetes\\.io/ingress\\.class"
    value = "nginx"
  }
  set_string {
    name  = "alertmanager.ingress.hosts"
    value = "{qa-alertmanager.varu.local}"
  }
  set {
    name  = "alertmanager.persistentVolume.enabled"
    value = "true"
  }
  set {
    name  = "alertmanager.persistentVolume.accessModes"
    value = "{ReadWriteMany}"
  }
  set {
    name  = "alertmanager.annotations.kubernetes\\.io/storage-class\\.class"
    value = "nfs-client"
  }
  set {
    name  = "alertmanager.persistentVolume.size"
    value = "2Gi"
  }

## KubeStateMetrics ##
  set {
    name  = "kubeStateMetrics.enabled"
    value = "true"
  }
  set_string {
    name  = "kubeStateMetrics.image.tag"
    value = "v1.9.0"
  }

## Server ##
  set {
    name  = "server.enabled"
    value = "true"
  }
  set_string {
    name  = "server.image.tag"
    value = "v2.15.2"
  }
  set {
    name  = "server.ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "nginx"
  }
  set_string {
    name  = "server.ingress.hosts"
    value = "{qa-prometheus.varu.local}"
  }
  set {
    name  = "server.persistentVolume.enabled"
    value = "true"
  }
  set {
    name  = "server.persistentVolume.accessModes"
    value = "{ReadWriteMany}"
  }
  set {
    name  = "server.annotations.volume.beta.kubernetes\\.io/storage-class\\.class"
    value = "nfs-client"
  }
  set {
    name  = "server.persistentVolume.size"
    value = "5Gi"
  }

## Pushgateway ##
  set {
    name  = "pushgateway.enabled"
    value = "true"
  }
  set_string {
    name  = "pushgateway.image.tag"
    value = "v1.0.1"
  }
  set {
    name  = "pushgateway.ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "nginx"
  }
  set_string {
    name  = "pushgateway.ingress.hosts"
    value = "{qa-pushgateway.varu.local}"
  }
  set {
    name  = "pushgateway.persistentVolume.enabled"
    value = "true"
  }
  set {
    name  = "pushgateway.persistentVolume.accessModes"
    value = "{ReadWriteMany}"
  }
  set {
    name  = "pushgateway.persistentVolume.size"
    value = "2Gi"
  }
}


resource "null_resource" "helm_destroy" {
  provisioner "local-exec" {
    when = destroy

    command = <<EOF
      helm delete --purge ${var.metrics_server_name} ${var.prometheus_name} --tiller-namespace ${var.tiller_namespace}
    EOF
    on_failure = continue
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

