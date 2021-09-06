# Каждый модуль требует отдельного обозначения провайдеров 🤬
# Наследуется только конфигурация от родительского main.tf
# https://www.terraform.io/docs/language/modules/develop/providers.html#implicit-provider-inheritance
terraform {
  required_providers {
    selectel = {
      source = "selectel/selectel"
      version = "3.6.2"
    }
  }
}

# MKS cluster definition
resource "selectel_mks_cluster_v1" "cluster_1" {
  name                              = var.cluster_name
  project_id                        = var.project_id
  region                            = var.region
  kube_version                      = var.kube_version
  enable_autorepair                 = var.enable_autorepair
  enable_patch_version_auto_upgrade = var.enable_patch_version_auto_upgrade
  network_id                        = var.network_id
  subnet_id                         = var.subnet_id
  maintenance_window_start          = var.maintenance_window_start
}

# MKS node group
resource "selectel_mks_nodegroup_v1" "nodegroup_1" {
  cluster_id        = selectel_mks_cluster_v1.cluster_1.id
  project_id        = selectel_mks_cluster_v1.cluster_1.project_id
  region            = selectel_mks_cluster_v1.cluster_1.region
  availability_zone = var.availability_zone
  nodes_count       = var.nodes_count
  keypair_name      = var.keypair_name
  cpus              = var.cpus
  ram_mb            = var.ram_mb
  volume_gb         = var.volume_gb
  volume_type       = var.volume_type
}

data "http" "kubeconfig" {
  url = "https://${selectel_mks_cluster_v1.cluster_1.region}.mks.selcloud.ru/v1/clusters/${selectel_mks_cluster_v1.cluster_1.id}/kubeconfig"

  request_headers = {
    X-Auth-Token = var.token
  }
}
