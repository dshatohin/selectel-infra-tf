output "project_id" {
  value = selectel_vpc_project_v2.project_1.id
}

output "project_url" {
  value = selectel_vpc_project_v2.project_1.url
}

output "os_token_id" {
  value = selectel_vpc_token_v2.project_1.id
  sensitive = true
}
