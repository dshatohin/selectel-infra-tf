terraform {
  backend "s3" {
    bucket = "tf-state"
    key    = "selectel-infra-tf.json"
    region = "ru-1"

    skip_region_validation      = true
    skip_credentials_validation = true
    force_path_style            = true

    endpoint   = "s3.selcdn.ru"
  }
}

module "vpc" {
  source = "./modules/vpc"

  project_name  = var.project_name
  user_name     = var.user_name
  user_password = var.user_password
}

module "mks" {
  depends_on = [
    module.vpc
  ]

  source = "./modules/mks"

  # Extra vars
  token = module.vpc.os_token_id

  # Cluster vars
  project_id                        = module.vpc.project_id
  cluster_name                      = var.cluster_name
  region                            = var.region
  kube_version                      = var.kube_version
  enable_autorepair                 = var.enable_autorepair
  enable_patch_version_auto_upgrade = var.enable_patch_version_auto_upgrade

  # Node group vars
  availability_zone = var.availability_zone
  nodes_count       = var.nodes_count
  cpus              = var.cpus
  ram_mb            = var.ram_mb
  volume_gb         = var.volume_gb
  volume_type       = var.volume_type
}

module  "k8s" {
  depends_on = [
    module.mks
  ]

  source = "./modules/k8s"

  volume_type       = var.volume_type
  availability_zone = var.availability_zone
}

module "dns" {
  depends_on = [
    module.k8s
  ]

  source = "./modules/dns"

  domain      = var.domain_name
  ingress     = module.k8s.lb_ip_address
}
