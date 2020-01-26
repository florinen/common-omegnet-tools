data "terraform_remote_state" "base_config" {
  backend = "consul"

  config = {
    address = "consul.omegnet.com"
    scheme  = "http"
    path    = "${var.provider_name}/${var.deployment_environment}/${var.state_file_name}"
  }
}

