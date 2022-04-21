module "gencompose" {
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

  internal_ip_address = var.internal_ip_address

  sg_enable   = var.sg_enable
  sg          = var.sg
  platform_id = var.platform_id
}

resource "null_resource" "gencompose" {
  provisioner "local-exec" {
    command = <<EOF
        ansible-playbook -i ${module.gencompose.internal_ip[0]},                                   \
        ${path.module}/provision/deploy.yml -v                                                       \
        -e service_name='${var.vm_name}'                                                           \
        -e custom_config='${base64encode(var.custom_config)}'
    EOF
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_CONFIG            = "${path.module}/ansible.cfg"
    }
  }
  depends_on = [module.gencompose]
}
