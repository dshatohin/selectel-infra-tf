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

resource "selectel_vpc_project_v2" "project_1" {
  name        = var.project_name
  auto_quotas = true
}

resource "selectel_vpc_user_v2" "user_1" {
  name     = var.user_name
  password = var.user_password
  enabled  = true
}

resource "selectel_vpc_role_v2" "role_tf_acc_test_1" {
  project_id = "${selectel_vpc_project_v2.project_1.id}"
  user_id    = "${selectel_vpc_user_v2.user_1.id}"
}

resource "selectel_vpc_token_v2" "project_1" {
  project_id = selectel_vpc_project_v2.project_1.id
}
