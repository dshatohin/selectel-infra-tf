# Каждый модуль требует отдельного обозначения провайдеров 🤬
# Наследуется только конфигурация от родительского main.tf
# https://www.terraform.io/docs/language/modules/develop/providers.html#implicit-provider-inheritance
terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "3.6.0"
    }
  }
}

resource "gitlab_group_variable" "kubeconfig" {
   group         = var.group_name
   key           = "KUBECONFIG"
   value         = var.kubeconfig
   variable_type = "file"
   protected     = false
   masked        = false
}
