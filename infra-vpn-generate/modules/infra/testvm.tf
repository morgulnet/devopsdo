module "testvm" {
  source = "../../../tfmodules/generic"

  # vm settings
  vm_name             = "testvm"
  image_id            = data.yandex_compute_image.ubuntu-latest.id
  num                 = 0
  cpu                 = 2
  memory              = 4
  disk                = 50
  internal_ip_address = "192.168.101.44"
  nat                 = false
  subnet_id           = var.subnet_id
}