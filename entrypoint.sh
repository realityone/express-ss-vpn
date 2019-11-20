#!/bin/sh

set -x

umount /etc/resolv.conf
echo "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > /etc/resolv.conf

gateway=`ip route get 8.8.8.8 | grep src | awk '{print $3}'`

iptables -A OUTPUT -t mangle -p tcp --sport 8388 -j MARK --set-mark 0x1
# iptables -A OUTPUT -t mangle -p udp --sport 8388 -j MARK --set-mark 0x1
if [[ ! -z $INGRESS_IP ]]; then
    ip route add $INGRESS_IP via $gateway dev eth0
fi

ip route add table 100 default via $gateway dev eth0
ip rule add fwmark 0x1 table 100

exec supervisord -n
