FROM ubuntu:16.04

ENV EXPRESSVPN_CLIENT_DOWNLOAD_VERSION 2.1.0-1
ENV EXPRESSVPN_CLIENT_VERSION 2.1.0
ENV EXPRESSVPN_CLIENT_BUILD 7586
ENV SHADOWSOCKS_VERSION v1.7.0-alpha.19

RUN apt update && \
    apt install -y iproute2 wget curl iptables iputils* net-tools xz-utils supervisor && \
    echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > /etc/resolv.conf && \
    wget https://download.expressvpn.xyz/clients/linux/expressvpn_${EXPRESSVPN_CLIENT_DOWNLOAD_VERSION}_amd64.deb -O /opt/expressvpn.deb && \
    wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SHADOWSOCKS_VERSION}/shadowsocks-${SHADOWSOCKS_VERSION}-nightly.x86_64-unknown-linux-musl.tar.xz -O /opt/shadowsocks.tar.xz && \
    cd /opt/ && \
    apt install -y ./expressvpn.deb && \
    xz -d ./shadowsocks.tar.xz && \
    tar xf ./shadowsocks.tar && \
    cd / && \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/expressvpn

ENV VPN_LOCATION=usla1
CMD ["/entrypoint.sh"]

ADD ./supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD ./entrypoint.sh /entrypoint.sh

