terraform {
  backend "consul" {
    address  = "consul.varu.local"
    scheme   = "http"
    path     = "prod-env/consul_prod"
  }
}
