resource "yandex_dns_zone" "devopsdo" {
  name             = "devopsdo"
  description      = "Devops.do"
  zone             = "devops.do."
  public           = false
  private_networks = [yandex_vpc_network.dev-network.id]
}

resource "yandex_dns_recordset" "testvm" {
  zone_id    = yandex_dns_zone.devopsdo.id
  name       = "testvm.devops.do."
  type       = "A"
  ttl        = 300
  data       = ["192.168.101.44"]
  depends_on = [yandex_dns_zone.devopsdo]
}

resource "yandex_dns_recordset" "strapi" {
  zone_id    = yandex_dns_zone.devopsdo.id
  name       = "strapi.devops.do."
  type       = "A"
  ttl        = 300
  data       = ["192.168.101.34"]
  depends_on = [yandex_dns_zone.devopsdo]
}