resource "yandex_kubernetes_node_group" "node_groups" {

  cluster_id  = yandex_kubernetes_cluster.cluster.id
  name        = "terraform-k8s-node-grp"
  description = "Kubernetes node group created by terraform"
  version     = "1.23"

  instance_template {
    platform_id = "standard-v2"
    network_interface {
       nat         = true
       subnet_ids         = [var.subnet_id]
    }
    metadata = {
      ssh-keys = "ubunto:${file("~/.ssh/id_rsa.pub")}"
    }
    resources {
      cores         = 4
      core_fraction = 100
      memory        = 8
    }
    boot_disk {
      size = 30
      type = "network-hdd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }
  provisioner "local-exec" {
    command =  "rm /tmp/yc-terraform-k8s & yc managed-kubernetes cluster get-credentials terraform-k8s --external --force --kubeconfig=/tmp/yc-terraform-k8s"
  }
}
