resource "kubernetes_service" "nginx-ingress-controller-lb" {
  metadata {
    name = "nginx-ingress-controller-lb"
    namespace = "nginx-ingress-controller"
    annotations = {"yandex.cloud/load-balancer-type" = "internal", 
    "yandex.cloud/subnet-id" = "${data.external.get_subnet_id.result.ecoded_doc}"}
  }
  spec {
    selector = {
      "app.kubernetes.io/component" = "controller",
      "app.kubernetes.io/instance"  = "nginx-ingress-controller",
      "app.kubernetes.io/name" = "nginx-ingress-controller"
    }

    port {
      name        = "http"
      port       = 80
      protocol   = "TCP"
      target_port = "http"
    }

    type = "LoadBalancer"
  }
}

resource "null_resource" "dependencies" {
  triggers = {
    depends_on = "${join("", var.dependencies)}"
  }
}

resource "yandex_dns_recordset" "wc_kubernetes_dev" {
  zone_id = "${data.external.get_dnszone_id.result.ecoded_doc}"
  name    = "*.k8s.dev.devops.do."
  type    = "A"
  ttl     = 60
  data    = [data.kubernetes_service.nginx-ingress-controller-lb.status.0.load_balancer.0.ingress.0.ip]
    depends_on = [
    data.kubernetes_service.nginx-ingress-controller-lb
  ]
}
