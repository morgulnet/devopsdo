output "vm_count" {
  value = var.num
}

output "ip_addresses" {
  value = module.wireguard.ip_addresses
}
