terraform {
  backend "s3" {
    bucket  = "kube.omegnet.com"
    key     = "vsphere/dev/base-tools/base-tools.tfstate"
    region  = "eu-west-1"
  }
}
