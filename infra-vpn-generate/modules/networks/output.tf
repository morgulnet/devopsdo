output "dev_network_id" {
  value = yandex_vpc_network.dev-network.id
}

output "yandex_vpc_dev_network_id" {
  value = yandex_vpc_network.dev-network.id
}

output "yandex_vpc_subnet_pub_a_id" {
  value = yandex_vpc_subnet.dev-network-pub-a.id
}

output "yandex_vpc_subnet_priv_a_id" {
  value = yandex_vpc_subnet.dev-network-priv-a.id
}

output "yandex_vpc_subnet_dev_compute" {
  value = yandex_vpc_subnet.dev-compute.id
}

output "yandex_vpc_subnet_dev_k8s_a" {
  value = yandex_vpc_subnet.dev-k8s-network-a.id
}
