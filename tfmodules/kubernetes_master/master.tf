resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-admin" {
  folder_id = var.folder_id
  role      = "k8s.admin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-editor" {
  count     = var.vpc_folder_id != "" ? 1 : 0
  folder_id = var.vpc_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-k8s-clusters-agent" {
  count     = var.vpc_folder_id != "" ? 1 : 0
  folder_id = var.vpc_folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-user" {
  count     = var.vpc_folder_id != "" ? 1 : 0
  folder_id = var.vpc_folder_id
  role      = "vpc.user"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-publicAdmin" {
  count     = var.vpc_folder_id != "" ? 1 : 0
  folder_id = var.vpc_folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
}

resource "yandex_kubernetes_cluster" "cluster" {
  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor
  ]
  name               = var.k8s_env
  description        = var.k8s_env
  cluster_ipv4_range = var.cluster_ipv4_range
  service_ipv4_range = var.service_ipv4_range
  network_id         = var.network_id

  master {
    version = var.version_k8s
    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }

    public_ip = var.public_ip

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "00:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = yandex_iam_service_account.k8s.id
  node_service_account_id = yandex_iam_service_account.k8s.id

  labels = {
    env = var.k8s_env
  }

  release_channel         = var.release_channel
  network_policy_provider = var.network_policy_provider

}