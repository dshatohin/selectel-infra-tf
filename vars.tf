# API token
variable "sel_token" {
  default = ""
  sensitive = true
}

# VPC module vars
variable "project_name" {
  default = "infra"
}

variable "user_name" {
  default = "infra_user"
}

variable "user_password" {
  default   = ""
  sensitive = true
}

# DNS module vars
variable "domain_name" {
  default = "shatoh.in"
}

# MKS module vars
variable "cluster_name" {
  default = "cluster-01"
}

variable "region" {
  default = "ru-3"
}

variable "kube_version" {
  default = "1.18.20"
}

variable "enable_autorepair" {
  default = true
}

variable "enable_patch_version_auto_upgrade" {
  default = true
}

variable "availability_zone" {
  default = "ru-3a"
}

variable "nodes_count" {
  default = 2
}

variable "cpus" {
  default = 2
}

variable "ram_mb" {
  default = 2048
}

variable "volume_gb" {
  default = 16
}

variable "volume_type" {
  default = "fast.ru-3a"
}
