module "nat-instance" {
  source = "../../../tfmodules/generic"

  # vm settings
  vm_name             = "nat"
  image_id            = "fd80mrhj8fl2oe87o4e1"
  num                 = 1
  cpu                 = 2
  memory              = 4
  disk                = 50
  internal_ip_address = var.dev_nat_ip
  nat                 = true
  subnet_id           = var.subnet_id

 # nat_ip_address      = module.nat.external_address
 # If u need static outgoing ip
}