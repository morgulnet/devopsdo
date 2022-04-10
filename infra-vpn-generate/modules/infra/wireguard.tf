module "wireguard" {
  source = "../../../tfmodules/wireguard"

  # vm settings
  vm_name             = "wireguard"
  image_id            = "fd8doth0oleutak3rt3j"
  num                 = 1
  cpu                 = 2
  memory              = 4
  disk                = 50
  internal_ip_address = "192.168.101.33"
  nat                 = true
  nat_ip_address      = module.wireguardip.external_address
  subnet_id = var.subnet_id

    wireguard_custom_server_config = <<EOF
# The place for a custom server config
EOF
  # custom settings
}
