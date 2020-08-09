terraform {
  required_version = "> 0.12.0"
}
provider "kubernetes" {
  version = "~> 1.10"
}

provider "null" {
  version = "~> 2.1"
}

provider "external" {
  version = "~> 1.2"
}

provider "template" {
  version = "~> 2.1"
}