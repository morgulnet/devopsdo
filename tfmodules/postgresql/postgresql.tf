resource "yandex_mdb_postgresql_cluster" "managed_postgresql" {
  name        = var.cluster_name
  network_id  = var.network_id
  description = var.description
  
  environment = var.environment

  config {
    version = var.database_version
    resources {
      resource_preset_id = var.resource_preset_id
      disk_size          = var.disk_size
      disk_type_id       = var.disk_type_id
    }
  }

  dynamic "user" {
    for_each = var.users
    content {
      name     = user.value.name
      password = user.value.password == "" || user.value.password == null ? random_password.pwd.result : user.value.password

      dynamic "permission" {
        for_each = var.user_permissions[user.value.name]
        content {
          database_name = permission.value.database_name
        }
      }
    }
  }
    
  dynamic "database" {
    for_each = var.databases
    content {
      name  = database.value.name
      owner = database.value.owner
    }
  }

  dynamic "host" {
    for_each = var.hosts
    content {
      zone             = host.value.zone
      subnet_id        = host.value.subnet_id
      assign_public_ip = host.value.assign_public_ip
    }
  }

}
