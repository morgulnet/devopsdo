data "kubernetes_service" "nginx-ingress-controller-lb" {
  metadata {
    name      = "nginx-ingress-controller-lb"
    namespace = "nginx-ingress-controller"
  }
  depends_on = [
    kubernetes_service.nginx-ingress-controller-lb
  ]
}
