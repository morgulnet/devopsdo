output "service_account_info" {
  sensitive = true
  value = [ 
    for key, value in yandex_iam_service_account_static_access_key.user-static-key:
    {
      "access_key" = value.access_key
      "secret_key" = value.secret_key
      "service_account_name" = yandex_iam_service_account.user-sa[key].name
    } 
  ]
}

output "bucket_name" {
  value = [
    for storage in yandex_storage_bucket.storage : storage.bucket
  ]
}
