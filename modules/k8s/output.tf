output "lb_ip_address" {
  value = data.kubernetes_service.contour.status.0.load_balancer.0.ingress.0.ip
}
