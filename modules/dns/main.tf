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

resource "selectel_domains_domain_v1" "domain_1" {
  name = var.domain
}

resource "selectel_domains_record_v1" "a_record_1" {
  domain_id = selectel_domains_domain_v1.domain_1.id
  name = "*.${var.domain}"
  type = "A"
  content = var.ingress
  ttl = 60
}
