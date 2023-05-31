#!/bin/bash

set -x

NODE01_IP=10.2.0.70
NODE02_IP=10.2.0.71
NODE03_IP=10.2.0.72
NODE04_IP=10.2.0.73

case $HOSTNAME in
  cube01 | cube02 | cube03 | cube04) echo -n "Hostname configured correctly. Proceeding." ;;
  *) echo -n "Hostnames not configured correctly. Exiting."; exit 1; ;;
esac

# play #1 - all hosts

CONTROL_NODE_IP=10.2.0.70
K3S_JOIN_TOKEN=myrandompassword

apt update -y
apt upgrade -y

cat > /etc/hosts <<EOF
127.0.0.1 localhost
$NODE01_IP cube01 cube01.local
$NODE02_IP cube02 cube02.local
$NODE03_IP cube03 cube03.local
$NODE04_IP cube04 cube04.local
EOF

apt -y install iptables

if [[ "$HOSTNAME" = "cube01" ]]; then
	# play #2 - cube01
	curl -sfL https://get.k3s.io | sh -s - \
		--write-kubeconfig-mode 644 \
		--disable servicelb \
		--token $K3S_JOIN_TOKEN \
		--node-ip $CONTROL_NODE_IP \
		--disable-cloud-controller \
		--disable local-storage
else
	# play #3 - cube02, cube03, cube04
	curl -sfL https://get.k3s.io | K3S_URL=https://${CONTROL_NODE_IP}:6443 K3S_TOKEN=$K3S_JOIN_TOKEN sh -
fi
