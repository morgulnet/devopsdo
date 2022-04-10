resource "yandex_kubernetes_cluster" "cluster" {
  name                    = "terraform-k8s"
  description             = "Created by kubernates"
  folder_id               = var.folder_id
  network_id              = var.network_id
  service_account_id      = yandex_iam_service_account.k8s_cluster_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_cluster_sa.id
  release_channel         = "RAPID"

  master {
    version   = "1.21"
    public_ip = true

    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
  }
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_cluster_sa_role
  ]
}

resource "yandex_iam_service_account" "k8s_cluster_sa" {
  name        = "k8s-cluster"
  description = "Service account to manage k8s"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_cluster_sa_role" {
  folder_id = var.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster_sa.id}"
  role      = "editor"
}
