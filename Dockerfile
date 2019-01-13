FROM ubuntu:16.04

ENV EXPRESSVPN_CLIENT_VERSION 1.5.1
ENV EXPRESSVPN_CLIENT_BUILD 5496
ENV SHADOWSOCKS_VERSION v1.7.0-alpha.19

RUN apt update && \
    apt install -y iproute2 wget curl iptables iputils* net-tools xz-utils supervisor && \
    echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > /etc/resolv.conf && \
    wget https://download.expressvpn.xyz/clients/linux/expressvpn_${EXPRESSVPN_CLIENT_VERSION}_amd64.deb -O /opt/expressvpn.deb && \
    apt install -y /opt/expressvpn.deb && \
    wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SHADOWSOCKS_VERSION}/shadowsocks-${SHADOWSOCKS_VERSION}-nightly.x86_64-unknown-linux-musl.tar.xz -O /opt/shadowsocks.tar.xz && \
    xz -d /opt/shadowsocks.tar.xz && \
    tar xf /opt/shadowsocks.tar

VOLUME /var/lib/expressvpn

ENV VPN_LOCATION=usla1
CMD ["/entrypoint.sh"]

ADD ./supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD ./entrypoint.sh /entrypoint.sh
