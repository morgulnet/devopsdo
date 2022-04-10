resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "${var.sa_name}-storage-admin-sa"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  depends_on         = [yandex_iam_service_account.sa]
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for ${var.sa_name} object storage"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-bucket-admin" {
  depends_on = [yandex_iam_service_account.sa]
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account" "user-sa" {
  for_each = { for key, value in var.permissions :
    key => value
  }
  folder_id   = var.folder_id
  name        = "${each.value.user}"
  description = "service account for bucket"
}

resource "yandex_iam_service_account_static_access_key" "user-static-key" {
  for_each = { for key, value in yandex_iam_service_account.user-sa :
    key => value
  }
  service_account_id = each.value.id
  description        = "${each.value.name} static access key"
}

resource "yandex_storage_bucket" "storage" {
  for_each = toset(var.bucket_names)
  depends_on = [yandex_iam_service_account_static_access_key.sa-static-key,
  yandex_resourcemanager_folder_iam_member.sa-bucket-admin,
  yandex_iam_service_account_static_access_key.user-static-key]
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = each.key
  force_destroy = var.force_destroy
  dynamic "grant" {
    for_each = var.permissions
    content {
      id = yandex_iam_service_account.user-sa[grant.key].id
      type = "CanonicalUser"
      permissions = grant.value.permission
    }
  }
  }
