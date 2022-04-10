module "alb" {
  source = "../../../tfmodules/alb"

  #alb
  alb_load_balancer_name = "dev-alb"
  network_id             = var.network_id
  external_address       = null
  #certificate_ids        = null
  listener_name          = "listener"
  listener_ports          = [80]
  subnet_id_internal_ip = var.subnet_id
  internal_address        = "192.168.101.111"
  allocations = [
    {
      zone_id    = "ru-central1-a"
       subnet_id = var.subnet_id
    }
  ]

  #cni
  default_certificate_ids = null
  sni_handlers = [
    {
      name = "vault-k8s-devopsdo",
      server_names = ["vault.k8s.devopsdo"],
      certificate_ids = [""]
    }
    ]

  #router
  alb_http_router_name = "vault-k8s-router"

  #backend_group
  alb_backend_group_name              = "test-k8s-backend-group"
  alb_http_backend = [
  {
  alb_backend_group_http_backend_name = "k8s-http-backend-name",
  alb_backend_group_http_backend_port = "30000",
  alb_target_group_name = "k8s-http-group-name",
  alb_weight = "1"
  }
  ]
  #virtual_host
  alb_virtual_host_name       = "hostname"
  alb_virtual_host_route_name = "test-route"
  alb_virtual_host_authority  = ["test.middle-api.magnit.test"]
  alb_virtual_host_timeout    = "30s"

#   #alb_target_group
alb_taget_group = {
  "k8s-group-name" = {
      alb_targets = [{
        alb_target_subnet_id = var.subnet_id
        alb_target_ip        = "192.168.101.2"
        }]
  },
}
}
