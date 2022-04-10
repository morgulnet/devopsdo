output "vm_count" {
  value = var.num
}

output "ip_addresses" {
  value = module.gencompose.ip_addresses
}
