terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
resource "yandex_vpc_network" "dev-network" {
  name = "dev-network"
}
# Create ya.cloud public subnet
resource "yandex_vpc_subnet" "dev-network-pub-a" {
  name           = "public-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.dev-network.id
  v4_cidr_blocks = ["10.1.101.0/24"]
}
resource "yandex_vpc_subnet" "dev-network-pub-b" {
  name           = "public-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.dev-network.id
  v4_cidr_blocks = ["10.1.102.0/24"]
}

# Create ya.cloud private subnet
resource "yandex_vpc_subnet" "dev-network-priv-a" {
  name           = "private-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.dev-network.id
  v4_cidr_blocks = ["192.168.101.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}
resource "yandex_vpc_subnet" "dev-network-priv-b" {
  name           = "private-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.dev-network.id
  v4_cidr_blocks = ["192.168.102.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}

# Kubernetes nodes subnet
resource "yandex_vpc_subnet" "dev-k8s-network-a" {
  name           = "dev-k8s-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.dev-network.id
  v4_cidr_blocks = ["192.168.111.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}
resource "yandex_vpc_subnet" "dev-k8s-network-b" {
  name           = "dev-k8s-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.dev-network.id
  v4_cidr_blocks = ["192.168.112.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}


resource "yandex_vpc_subnet" "dev-compute" {
  v4_cidr_blocks = ["10.1.11.0/24"]
  zone           = "ru-central1-a"
  name           = "dev-compute"
  network_id     = yandex_vpc_network.dev-network.id
}

resource "yandex_vpc_route_table" "route-table" {
  name = "nat-route"
  network_id = yandex_vpc_network.dev-network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.dev_nat_ip
  }
}
