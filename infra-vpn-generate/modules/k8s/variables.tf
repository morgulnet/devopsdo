variable "folder_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "sa_name" {
  type = string
}
variable "cloud_id" {
  type = string
}

variable "zone" {
  type = string
  default = "ru-central1-a"
}

variable "max_num" {
  type        = number
  description = "Number of nodes"
  default     = 1
}

variable "k8s_version" {
  type        = string
  description = "Version of nodes"
}

variable "pool_name" {
  type        = string
  description = "Pool node name"
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "nat" {
  type    = string
  default = false
}

variable "max_unavailable" {
  type    = number
  default = 0
}

variable "max_expansion" {
  type    = number
  default = 2
}

variable "k8s_zone" {
  description = "Set zone"
  type        = list(string)
  default     = ["ru-central1-a"]
}


variable "node_taints" {
  description = "List taint rules"
  type        = list(string)
  default     = []
}

variable "maintenance_window_day" {
  type    = string
  default = "saturday"
}

variable "maintenance_window_start_time" {
  type    = string
  default = "03:00"
}

variable "maintenance_window_duration" {
  type    = string
  default = "2h00m"
}

variable "labels_key" {
  type    = string
  default = "key"
}

variable "labels_value" {
  type    = string
  default = "value"
}
