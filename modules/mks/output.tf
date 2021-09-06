output "kubeconfig" {
  value     = yamldecode("${data.http.kubeconfig.body}")
  sensitive = true
}

output "kubeconfig_raw" {
  value     = "${data.http.kubeconfig.body}"
  sensitive = true
}
