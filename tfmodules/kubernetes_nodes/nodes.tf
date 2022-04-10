resource "yandex_kubernetes_node_group" "k8s_node_group" {
  cluster_id  = var.cluster_id
  name        = var.pool_name
  description = "pool for applications"
  version     = var.k8s_version

  labels = {
    key = var.labels_value
  }

  instance_template {
    platform_id = var.cpu_type

    network_interface {
      nat        = var.nat
      subnet_ids = var.subnet_id
    }


    resources {
      memory = var.memory
      cores  = var.cpu
    }

    boot_disk {
      type = var.disk_type
      size = var.disk
    }

    scheduling_policy {
      preemptible = false
    }

    metadata = {
      ssh-keys = <<EOF
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVH40nFbRMd/PUKTMRtTrNSTtS31+oWKvWvkt2iru92eX/ya6/fNz3nYOvwv0p1X/cXPnaH3w5b9BgGvmPVbsw4MR4KWNIes3nUZll26BnPPPrP7mt8poGEjPiiYt8ZqSGVRVN7EKs+qc4jgQS19M2v7H2eFqg1FJXupV5vK7DhLxfiL5GGXpCfVLcuYzlAbOcTMG2WAQtSWDybkWKRwtXM6dRj6m6/Zm3jhsW4ZsJ+EZpvYwXeKDwqDk/vE9dcHzTAIwIys8Yzlixzts2PhUMkZSuhfnWj+/LKt7x+K3ACnFLV6RIq2nVX7gl2J1kNhVrCFJaosI2XIe3HXUNEJ2j ubuntu
      EOF
    }

    scheduling_policy {
    preemptible = true
    }
  }

  scale_policy {
    auto_scale {
      min = var.num
      max = var.max_num
      initial = var.num
    }
  }

  allocation_policy {
    dynamic "location" {
      for_each = var.k8s_zone
      content {
        zone = location.value
      }

    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true


    maintenance_window {
      day        = var.maintenance_window_day
      start_time = var.maintenance_window_start_time
      duration   = var.maintenance_window_duration
    }
  }
  deploy_policy {
    max_unavailable = var.max_unavailable
    max_expansion   = var.max_expansion
  }

  node_taints = var.node_taints
}
