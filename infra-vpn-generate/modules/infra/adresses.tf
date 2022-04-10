module "alb-static-ip" {
  source = "../../../tfmodules/public-ip"

  zone             = "ru-central1-a"
  cloud_id         = var.cloud_id
  folder_id        = var.folder_id
  external_ip_name = "alb-ip"
}

module "wireguardip" {
  source = "../../../tfmodules/public-ip"

  zone             = "ru-central1-a"
  cloud_id         = var.cloud_id
  folder_id        = var.folder_id
  external_ip_name = "wireguardip"
}
