

variable "namespace" {
    description = "default namespace for all apps"
    default = "apps" 
}
variable    "jenkins_service_port"     {
  default = 8090
  description = "Please do not change this ports."
}
variable    "grafana_service_port"        {
  default = 8091
  description = "Please do not change this ports."
}

variable    "nexus_service_port"       {
  default = 8092
  description = "Please do not change this ports."
}

variable    "vault_service_port"       {
  default = 8093
  description = "Please do not change this ports."
}
variable    "consul_service_port"       {
  default = 8094
  description = "Please do not change this ports."
}

