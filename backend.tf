terraform {
  backend "consul" {
    address  = "consul.varu.local"
    scheme   = "http"
    path     = "vsphere/prod/common-tools/terraform.tfstate"
  }
}
