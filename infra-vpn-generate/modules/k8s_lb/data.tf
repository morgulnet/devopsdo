# data "external" "svc_internal_ip" {
#   program = ["bash", "${path.module}/get_svc_ip.bash"]

#   query = {
#     svc_name = "nginx-ingress-controller-lb"
#   }
# }

data "external" "get_subnet_id" {
  program = ["bash", "${path.module}/get_subnet_id.bash"]

  query = {
    subnet_name = "dev-k8s-a"
  }
}

data "external" "get_dnszone_id" {
  program = ["bash", "${path.module}/get_dnszone_id.bash"]

  query = {
    dnszone_name = "devopsdo"
  }
}

data "kubernetes_service" "nginx-ingress-controller-lb" {
  metadata {
    name      = "nginx-ingress-controller-lb"
    namespace = "nginx-ingress-controller"
  }
  depends_on = [
    kubernetes_service.nginx-ingress-controller-lb
  ]
}
