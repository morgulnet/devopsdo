terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "networks" {
  source = "./modules/networks"
  zone = var.zone
  dev_nat_ip = var.dev_nat_ip
}

module "compute" {
  source = "./modules/compute"
  network_id = module.networks.yandex_vpc_dev_network_id
  subnet_id = module.networks.yandex_vpc_subnet_priv_a_id
  subnet_dev_compute_id = module.networks.yandex_vpc_subnet_dev_compute
}

module "k8s" {
  source = "./modules/k8s"

  cloud_id   = var.cloud_id
  folder_id  = var.folder_id
  zone       = var.zone
  pool_name   = "asdasd"
  k8s_version = "1.21"
  network_id = module.networks.yandex_vpc_dev_network_id
  subnet_id  = module.networks.yandex_vpc_subnet_dev_k8s_a
  sa_name    = "dev-k8s"

}

module "infra" {
  source = "./modules/infra"

  network_id = module.networks.yandex_vpc_dev_network_id
  subnet_id = module.networks.yandex_vpc_subnet_priv_a_id
  #nat-public-ip = module.infra.nat-public-ip
  dev_nat_ip = "192.168.101.101"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "gitops" {
  source = "./modules/gitops"
  
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id

  #flux settings   
  github_owner     = var.github_owner
  github_token     = var.github_token
  repository_name  = "flux2_devopsdo"
  target_path      = "dev_cluster"
  dependencies = ["${module.networks.yandex_dns_zone_id}"]
}

module "k8s_lb" {
  source = "./modules/k8s_lb"

  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id

  yandex_dns_zone_id = module.networks.yandex_dns_zone_id
  
  dependencies = ["${module.networks.yandex_dns_zone_id}"]
}
