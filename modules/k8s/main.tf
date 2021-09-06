resource "helm_release" "contour_ingress" {
  name              = "contour"
  namespace         = "projectcontour"
  version           = "4.3.4"
  create_namespace  = true
  dependency_update = true
  wait_for_jobs     = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "contour"
}

data "kubernetes_service" "contour" {
  depends_on = [
    helm_release.contour_ingress,
  ]

  metadata {
    name      = "${helm_release.contour_ingress.name}-envoy"
    namespace = helm_release.contour_ingress.namespace
  }
}

resource "kubernetes_storage_class" "class_1" {
  metadata {
    name = var.volume_type
  }
  storage_provisioner = "cinder.csi.openstack.org"
  parameters = {
    type         = var.volume_type
    availability = var.availability_zone
  }
}
