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
  default     = 10
  type        = number
}

variable "zone" {
  description = "Default zone"
  default     = "ru-central1-a"
  type        = string
}

variable "image_id" {
  description = "Default image ID Ubuntu 20"
  default     = "fd89boblh6d5vruo39lm" # ubuntu-20-04-lts-v20211201
  type        = string
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "nat" {
  type    = bool
  default = false
}

variable "platform_id" {
  type    = string
  default = "standard-v2"
}

variable "internal_ip_address" {
  type    = string
  default = null
}

variable "nat_ip_address" {
  type    = string
  default = null
}

variable "dns_servers" {
  description = "A space-separated list of IPv4 and IPv6 addresses"
  type        = string
  default     = ""
}

variable "consul_reg" {
  type    = bool
  default = true
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

variable "disk_type" {
  description = "Disk type"
  type        = string
  default     = "network-ssd"
}

variable "create_certificate" {
  type    = bool
  default = false
}

variable "certificate_domain_name" {
  type    = string
  default = false
}

variable "certificate_ttl" {
  type    = string
  default = "8760h"
}

variable "destination_crt" {
  type    = string
  default = false
}

variable "destination_key" {
  type    = string
  default = false
}

variable "serial" {
  description = "Serial console"
  type    = number
  default = 0
}
