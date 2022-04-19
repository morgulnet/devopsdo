resource "yandex_vpc_security_group" "block-all" {
  name        = "Block all traffic"
  description = "Block all traffic"
  network_id  = "${yandex_vpc_network.dev-network.id}"
}

resource "yandex_vpc_security_group" "allow-all" {
  name        = "Allow all traffic"
  description = "Allow all traffic"
  network_id  = "${yandex_vpc_network.dev-network.id}"
  ingress {
    protocol       = "ANY"
    description    = "Allow all unbound connections"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    description    = "Allow all unbound connections"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "default-rule" {
  name        = "Default rules"
  description = "Default rules"
  network_id  = "${yandex_vpc_network.dev-network.id}"

ingress {
    protocol       = "ANY"
    description    = "Allow all inbound local traffic"
    v4_cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound local traffic"
    v4_cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow ssh traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "Allow icmp traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "wireguard-traffic" {
  name        = "Allow wireguard traffic"
  description = "Allow wireguard traffic"
  network_id  = "${yandex_vpc_network.dev-network.id}"

  ingress {
    protocol       = "UDP"
    description    = "Allow wireguard traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 51820
  }
}

resource "yandex_vpc_security_group" "http-https-traffic" {
  name        = "Allow http, https traffic"
  description = "Allow http, https traffic"
  network_id  = "${yandex_vpc_network.dev-network.id}"

  ingress {
    protocol       = "TCP"
    description    = "Allow http, https traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow http, https traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}
