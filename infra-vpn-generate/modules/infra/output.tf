output "alb-public-ip" {
  value = module.alb-static-ip.external_address
}
