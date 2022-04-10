#!/bin/ash

PRIVATE_CLIENT=$(wg genkey)
PUBLIC_CLIENT=$(printf $PRIVATE_CLIENT | wg pubkey)

PRIVATE_SERVER=$(wg genkey)
PUBLIC_SERVER=$(printf $PRIVATE_SERVER | wg pubkey)

cat > /tmp/wg0.conf << EOF
[Interface]
Address = 10.200.200.1
ListenPort = 51820
PrivateKey = $PRIVATE_SERVER
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

### Client admin
[Peer]
PublicKey = $PUBLIC_CLIENT
AllowedIPs = 10.200.200.2/32
EOF
cat > /tmp/client.conf << EOF
[Interface]
PrivateKey = $PRIVATE_CLIENT
Address = 10.200.200.2/32
DNS = 192.168.101.1

[Peer]
PublicKey = $PUBLIC_SERVER
AllowedIPs = 0.0.0.0/0, 10.200.200.1/32, 192.168.101.31/32
Endpoint = $IP:51820
EOF