resource "yandex_compute_instance" "generic" {
  count       = var.num
  name        = format("%s-%02d", var.vm_name, count.index + 1)
  hostname    = format("%s-%02d", var.vm_name, count.index + 1)
  platform_id = var.platform_id
  zone        = var.zone
  resources {
    cores  = var.cpu
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = var.nat
    ip_address         = var.internal_ip_address
    nat_ip_address     = var.nat_ip_address
    security_group_ids = var.sg_enable ? var.sg : null
  }

  metadata = {
    ssh-keys  = "ubuntu:${file("${path.module}/provision/files/id_rsa.pub")}"
    user-data = file("${path.module}/provision/files/meta.txt")
    serial-port-enable = var.serial
  }
  scheduling_policy {
    preemptible = true
  }
}

resource "null_resource" "node-exporter" {
  count = var.num
  provisioner "local-exec" {
    command = format("ansible-playbook -D -i %s, -u ubuntu %s/provision/node-exporter.yml",
      yandex_compute_instance.generic[count.index].network_interface[0].nat_ip_address != "" ? yandex_compute_instance.generic[count.index].network_interface[0].nat_ip_address : yandex_compute_instance.generic[count.index].network_interface[0].ip_address,
    path.module, )
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_CONFIG            = "${path.module}/ansible.cfg"
    }

  }
  depends_on = [yandex_compute_instance.generic]
}

resource "null_resource" "setup-dns" {
  count = length(var.dns_servers) > 0 ? var.num : 0 // Если dns_servers не пустая вернуть количество машин, иначе 0
  provisioner "local-exec" {
    command = format("ansible-playbook -D -i %s, -u ubuntu %s/provision/dns.yml -e dns_servers='%s'",
      yandex_compute_instance.generic[count.index].network_interface[0].nat_ip_address != "" ? yandex_compute_instance.generic[count.index].network_interface[0].nat_ip_address : yandex_compute_instance.generic[count.index].network_interface[0].ip_address,
      path.module,
    var.dns_servers)
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
  depends_on = [null_resource.node-exporter]
}
