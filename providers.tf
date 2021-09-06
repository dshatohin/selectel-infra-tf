terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
      version = "3.6.2"
    }
    http = {
      source = "hashicorp/http"
      version = "2.1.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.4.1"
    }
  }
}

provider "selectel" {
  token = var.sel_token
}

# Parse kubernetes connection data
locals {
  host                   = "${module.mks.kubeconfig.clusters[0].cluster.server}"
  client_certificate     = base64decode("${module.mks.kubeconfig.users[0].user.client-certificate-data}")
  client_key             = base64decode("${module.mks.kubeconfig.users[0].user.client-key-data}")
  cluster_ca_certificate = base64decode("${module.mks.kubeconfig.clusters[0].cluster.certificate-authority-data}")
}

provider "helm" {
  kubernetes {
    host = local.host

    client_certificate     = local.client_certificate
    client_key             = local.client_key
    cluster_ca_certificate = local.cluster_ca_certificate
  }
}

provider "kubernetes" {
  host = local.host

  client_certificate     = local.client_certificate
  client_key             = local.client_key
  cluster_ca_certificate = local.cluster_ca_certificate
}
