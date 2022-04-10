variable "alb_taget_group_name" {
  type        = string
  default     = null
  description = "name of alb target group"
}

variable "alb_backend_group_name" {
  type        = string
  default     = null
  description = "name of backend group name"
}

variable "alb_load_balancer_name" {
  type        = string
  default     = null
  description = "name alb"
}

variable "network_id" {
  type        = string
  default     = null
  description = "network id"
}

variable "external_address" {
  type        = string
  default     = null
  description = "external address"
}

variable "listener_name" {
  type        = string
  default     = "default-lister"
  description = "listener name"
}

variable "listener_ports" {
  type        = list(number)
  default     = [443]
  description = "listener port"
}

variable "default_certificate_ids" {
  type        = list(string)
  default     = null
  description = "certificate_ids"
}

variable "alb_http_router_name" {
  type        = string
  default     = "default-router"
  description = "http_router_name"
}

variable "alb_backend_group_http_backend_name" {
  type        = string
  default     = "test-backend-group-http-backend-name"
  description = "backend_group_http_backend_name"
}

variable "alb_backend_group_http_backend_port" {
  type        = number
  default     = 30080
  description = "alb_backend_group_http_backend_port"
}


variable "alb_virtual_host_name" {
  type        = string
  default     = "test-CHANGEME-virtual-hostname"
  description = "alb_virtual_host_name"
}

variable "alb_virtual_host_route_name" {
  type        = string
  default     = "test-CHANGEME-route"
  description = "alb_virtual_host_route_name"
}


variable "alb_virtual_host_authority" {
  type        = list(string)
  default     = ["test-CHANGEME-route.ya.ru"]
  description = "alb_virtual_host_authorit"
}

variable "sni_handler_name" {
  type        = string
  default     = null
  description = "Name of extra sni"
}

variable "sni_server_names" {
  type        = list(string)
  default     = null
  description = "domains"
}

variable "sni_certificate_ids" {
  type        = list(string)
  default     = null
  description = "id certificate of extra sni"
}

variable "allocations" {
  type = list(object({
    zone_id   = string
    subnet_id = string
  }))
}

variable "sni_handlers" {
  type = list(object({
    name            = string
    server_names    = list(string)
    certificate_ids = list(string)
  }))
}

variable "alb_virtual_host_timeout" {
  type        = string
  default     = "30s"
  description = "Timeout fot alb_virtual_host"
}

variable "alb_taget_group" {
  type = map(object({
    alb_targets = list(object({
      alb_target_subnet_id = string
      alb_target_ip        = string
    }))
  }))
}

variable "alb_http_backend" {
  type = list(object({
    alb_backend_group_http_backend_name = string,
    alb_backend_group_http_backend_port = string,
    alb_target_group_name               = string,
    alb_weight                          = string
  }))
  default = null
}

variable "subnet_id_internal_ip" {
  default = null
  type    = string
}

variable "internal_address" {
  type    = string
  default = null
}
