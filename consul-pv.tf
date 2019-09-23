resource "kubernetes_persistent_volume" "consul_pv_01" {
  metadata {
    name = "consul-pv01"

    labels = {
      volume = "${var.label}"
    }
  }

  spec {
    capacity = {
      storage = "10Gi"
    }
 
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Delete"
    storage_class_name               = "hostpath" 
    persistent_volume_source {
            host_path {
                path = "/nfs/shares/consul"
            }  
    }  
  }   
}