## VM parameters
variable "vm_name" {
  description = "VM name"
  type        = string
}

variable "num" {
  description = "Number of VMs"
  default     = 1
  type        = number
}

variable "cpu" {
  description = "VM CPU count"
  default     = 2
  type        = number
}

variable "memory" {
  description = "VM RAM size"
  default     = 2
  type        = number
}

variable "disk" {
  description = "VM Disk size"
  default     = null
  type        = number
}

variable "zone" {
  description = "Default zone"
  default     = "ru-central1-a"
  type        = string
}

variable "image_id" {
  description = "Ubuntu and docker"
  default     = "fd8doth0oleutak3rt3j"
  type        = string
}

variable "subnet_id" {
  type = string
}

variable "dns_servers" {
  description = "A space-separated list of IPv4 and IPv6 addresses"
  type        = string
  default     = ""
}

variable "nat_ip_address" {
  type = string
  default = null
}

variable "internal_ip_address" {
  type = string
}

variable "config_name" {
  type    = string
  default = "wg0.conf"
}

variable "sg" {
  description = "SG id"
  type        = list(any)
  default     = null
}

variable "sg_enable" {
  description = "Enable or disable security group"
  type        = bool
  default     = false
}

variable "platform_id" {
  type    = string
  default = "standard-v1"
}

variable "nat" {
  type    = bool
  default = false
}

variable "custom_config" {
  type = string
}

variable "vault_path_secret" {
  type = string
  default = "infra/ycloud/dev/infra/example"
}
