terraform {
  backend "consul" {
    address  = "consul.varu.local"
    scheme   = "http"
    path     = "vsphere/qa/common-tools/terraform.tfstate"
  }
}
