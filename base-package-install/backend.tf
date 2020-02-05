terraform {
  backend "s3" {
    bucket  = "kube.omegnet.com"
    key     = "vsphere/prod/base-tools/base-tools.tfstate"
    region  = "eu-west-1"
  }
}
