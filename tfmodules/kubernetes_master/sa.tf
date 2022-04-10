resource "yandex_iam_service_account" "k8s" {
  name        = "k8s-${var.k8s_env}"
  description = "service account for kubernetes"
  folder_id   = var.folder_id
}
