output "dnszone_id" {
  value = data.external.get_dnszone_id.result.ecoded_doc
}

output "svc_internal_ip" {
  value = data.external.svc_internal_ip.result.ecoded_doc
}

output "subnet_id" {
  value = data.external.get_subnet_id.result.ecoded_doc
}
# output "ingress" {
#   value = data.kubernetes_service.nginx-ingress-controller-lb.status.0.load_balancer.0.ingress.0.ip
# }
