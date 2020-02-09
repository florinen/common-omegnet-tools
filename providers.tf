provider "kubernetes" {
  version = "~> 1.10"
}

provider "helm" {
  version = "~> 0.10"
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