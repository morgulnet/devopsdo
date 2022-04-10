resource "yandex_vpc_address" "addr" {
  name = var.external_ip_name
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}
