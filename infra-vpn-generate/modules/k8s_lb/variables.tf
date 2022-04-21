variable "token" {
  description = "Yandex.Cloud Token"
  type = string
}

variable "cloud_id" {
  description = "Cloud Id"
  type = string
}

variable "folder_id" {
  description = "Folder Id"
  type = string
}

variable "yandex_dns_zone_id" {
  description = "yandex_dns_zone Id"
  type = string
}

variable "yandex_vpc_subnet_dev_k8s_a" {
  description = "yandex_vpc_subnet_dev_k8s_a Id"
  type = string
}

variable "dependencies" {
  # Do the following in the module declaration:
  # dependencies = ["${some_resource.resource_alias.id}"]
  default     = []
  type        = any
  description = "Resources/modules that this module depends on. Regular `depends_on` block do not work for this module."
}
