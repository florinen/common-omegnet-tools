
data "helm_repository" "stable" {
  depends_on = ["null_resource.helminit"]
  name       = "stable"
  #url  = "https://kubernetes-charts.storage.googleapis.com"
  url        = "https://fuchicorp.github.io/helm_charts"
}

resource "helm_release" "metallb" {
  depends_on = ["data.helm_repository.stable"]
  name       = "metallb"
  namespace  = "metallb-system"
  force_update = true
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "metallb"
  wait       = false
  
  # values = [
  #   "${file("configInline.yaml")}"
  # ]
  # set {
  #     name = "configInline"
  #     value = 
  #   }
}
