variable "zone" {
  type        = string
  default     = null
  description = "Zone of yandex cloud"

}

variable "cloud_id" {
  type    = string
  default = null
}

variable "folder_id" {
  type    = string
}

variable "cluster_id" {
  type    = string
  default = null
}

variable "service_account_id" {
  type    = string
  default = null
}

variable "node_service_account_id" {
  type    = string
  default = null
}

variable "version_k8s" {
  type    = string
  default = null
}

variable "k8s_env" {
  type    = string
  default = null
}

variable "ip_subnet" {
  type    = list(string)
  default = null
}

variable "network_id" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "cluster_ipv4_range" {
  type    = string
  default = "10.112.0.0/16"
}

variable "service_ipv4_range" {
  type    = string
  default = "10.96.0.0/16"
}

variable "vpc_folder_id" {
  type    = string
  default = ""
}

variable "sa_name" {
  type    = string
}

variable "network_policy_provider" {
  type    = string
  default = "CALICO"
}

variable "release_channel" {
  type    = string
  default = "REGULAR"
}

variable "public_ip" {
  type    = bool
  default = true
}
