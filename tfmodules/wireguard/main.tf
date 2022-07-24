module "wireguard" {
  source = "../generic"

  ## VM parameters
  vm_name  = var.vm_name
  num      = var.num
  cpu      = var.cpu
  memory   = var.memory
  image_id = var.image_id

  zone = var.zone
  nat  = var.nat

  dns_servers = var.dns_servers
  subnet_id   = var.subnet_id

  nat_ip_address      = var.nat_ip_address
  internal_ip_address = var.internal_ip_address

  sg_enable   = var.sg_enable
  sg          = var.sg
  platform_id = var.platform_id
}

resource "null_resource" "wireguard" {
  provisioner "local-exec" {
    command = <<EOF
        ansible-playbook -i ${join(",", module.wireguard.ip_addresses)},                                        \
        ${path.module}/provision/deploy_wireguard.yml -v                                                           \
        -e wireguard_custom_server_config='${base64encode(var.wireguard_custom_server_config)}'
    EOF
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_CONFIG            = "${path.module}/ansible.cfg"
    }
  }
  depends_on = [module.wireguard]
}
