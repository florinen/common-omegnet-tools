terraform {
  backend "consul" {
    address  = "consul.varu.local"
    scheme   = "http"
    path     = "vsphere/dev/common-tools/terraform.tfstate"
  }
}
