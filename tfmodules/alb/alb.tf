resource "yandex_alb_load_balancer" "alb_load_balancer" {

  name = var.alb_load_balancer_name

  network_id = var.network_id

  allocation_policy {
    dynamic "location" {
      for_each = var.allocations
      content {
        zone_id   = location.value["zone_id"]
        subnet_id = location.value["subnet_id"]
      }
    }
  }

  listener {
    name = var.listener_name
    endpoint {
      address {
        dynamic "external_ipv4_address" {
          for_each = var.external_address != null ? [0] : []
          content {
            address = var.external_address
          }
        }

        dynamic "internal_ipv4_address" {
          for_each = var.internal_address != null ? [0] : []
          content {
            address   = var.internal_address
            subnet_id = var.subnet_id_internal_ip
          }
        }
        # external_ipv4_address {
        #   address = var.external_address
        # }
        # internal_ipv4_address {
        #   address = var.internal_address
        #   subnet_id = var.subnet_id_internal_ip
        # }
      }
      ports = var.listener_ports
    }
    tls {
      default_handler {
        certificate_ids = var.default_certificate_ids
        http_handler {
          http_router_id = yandex_alb_http_router.alb_http_router.id
        }
      }
      dynamic "sni_handler" {
        for_each = var.sni_handlers
        content {
          name         = sni_handler.value["name"]
          server_names = sni_handler.value["server_names"]
          handler {
            certificate_ids = sni_handler.value["certificate_ids"]
            http_handler {
              http_router_id = yandex_alb_http_router.alb_http_router.id
            }
          }
        }
      }
    }
  }
}

#router
resource "yandex_alb_http_router" "alb_http_router" {
  name = var.alb_http_router_name
}

#virtual_host->backend_group
resource "yandex_alb_virtual_host" "alb_virtual_host" {
  name           = var.alb_virtual_host_name
  authority      = var.alb_virtual_host_authority
  http_router_id = yandex_alb_http_router.alb_http_router.id
  route {
    name = var.alb_virtual_host_route_name
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.alb_backend_group.id
        timeout          = var.alb_virtual_host_timeout
      }
      http_match {
        http_method = []
        path {
          prefix = "/"
        }
      }
    }
  }
}

#backend_group -> alb_target_group
resource "yandex_alb_backend_group" "alb_backend_group" {
  name = var.alb_backend_group_name
  dynamic "http_backend" {
    for_each = var.alb_http_backend
    content {
      name             = http_backend.value.alb_backend_group_http_backend_name
      weight           = http_backend.value.alb_weight
      port             = http_backend.value.alb_backend_group_http_backend_port
      target_group_ids = ["${yandex_alb_target_group.alb_target_group[http_backend.value.alb_target_group_name].id}"]
      // tls {
      //   sni = "backend-domain.internal"
      // }
      load_balancing_config {
        panic_threshold                = 0
        locality_aware_routing_percent = 0
        strict_locality                = false
      }
      // healthcheck {
      //   timeout  = "5s"
      //   interval = "10s"
      //   http_healthcheck {
      //     path = "/v1/cities"
      //   }
      // }
      http2 = "false"
    }
  }
}

resource "yandex_alb_target_group" "alb_target_group" {
  for_each = var.alb_taget_group
  name     = each.key
  dynamic "target" {
    for_each = each.value.alb_targets
    content {
      ip_address = target.value["alb_target_ip"]
      subnet_id  = target.value["alb_target_subnet_id"]
    }
  }
}
