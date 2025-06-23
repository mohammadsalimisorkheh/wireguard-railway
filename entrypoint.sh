#!/bin/bash

# تولید کلیدها اگر وجود ندارند
mkdir -p /etc/wireguard

if [ ! -f /etc/wireguard/privatekey ]; then
    umask 077
    wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey
fi

PRIVATE_KEY=$(cat /etc/wireguard/privatekey)

# پیکربندی اولیه WireGuard
cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
Address = 10.0.0.1/24
PrivateKey = $PRIVATE_KEY
ListenPort = 51820

# مثال یک Peer
#[Peer]
#PublicKey = <peer-public-key>
#AllowedIPs = 10.0.0.2/32
EOF

# راه‌اندازی اینترفیس WireGuard
wg-quick up wg0 || (echo "خطا در اجرای WireGuard" && exit 1)

# نگه داشتن کانتینر فعال
tail -f /dev/null
