module "freeipa" {
  source = "../../../tfmodules/generic-compose"

  # vm settings
  vm_name             = "freeipa"
  image_id            = "fd8doth0oleutak3rt3j"
  num                 = 1
  cpu                 = 2
  memory              = 4
  disk                = 50
  internal_ip_address = "192.168.101.44"
  nat                 = false
  subnet_id           = var.subnet_id
  
  custom_config = <<EOF
version: '3.3'
services:
  freeipa:
    image: freeipa/freeipa-server:fedora-33
    hostname: freeipa.devops.do
    volumes:
      - "/sys/fs/cgroup:/sys/fs/cgroup:ro"
      - "/var/lib/freeipa/:/data:Z"
    command:
      - "ipa-server-install"
      - "--unattended"
      - "--realm=DEVOPS.DO"
      - "--ds-password=password"
      - "--admin-password=adminpassword"
      - "--no-ntp"
    ports:
      - 80:80/tcp
      - 443:443/tcp
      - 389:389/tcp
      - 636:636/tcp
    sysctls:
      - net.ipv6.conf.all.disable_ipv6=0
    tmpfs:
      - /run
      - /tmp
EOF
  # custom settings
}
