output "internal_ip" {
  value = yandex_compute_instance.generic.*.network_interface.0.ip_address
}

output "vm_count" {
  value = var.num
}

output "ip_addresses" {
  value = yandex_compute_instance.generic.*.network_interface.0.nat_ip_address
}

output "hostname" {
  value = yandex_compute_instance.generic.*.hostname
}
