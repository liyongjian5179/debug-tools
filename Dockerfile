FROM redis:4.0.14-alpine3.10 as redis-builder

FROM alpine:3.10

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.10/main" > /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.10/community" >> /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/edge/main" >> /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    tzdata \
    apache2-utils \
    bash \
    bind-tools \
    bird \
    bridge-utils \
    busybox-extras \
    conntrack-tools \
    curl \
    dhcping \
    drill \
    ethtool \
    file\
    fping \
    iftop \
    iperf \
    iproute2 \
    ipset \
    iptables \
    iptraf-ng \
    iputils \
    ipvsadm \
    libc6-compat \
    liboping \
    mtr \
    net-snmp-tools \
    netcat-openbsd \
    nftables \
    ngrep \
    nmap \
    nmap-nping \
    openssl \
    py-crypto \
    py2-virtualenv \
    python2 \
    sox \
    graphviz \
    ebtables \
    scapy \
    socat \
    strace \
    gdb \
    tcpdump \
    tcptraceroute \
    util-linux \
    jq \
    vim \
    htop \
    mysql-client 

# Timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# Installing ctop - top-like container monitor
RUN wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 -O /usr/local/bin/ctop && chmod +x /usr/local/bin/ctop

# Installing calicoctl
ARG CALICOCTL_VERSION=v3.3.1
RUN wget https://github.com/projectcalico/calicoctl/releases/download/${CALICOCTL_VERSION}/calicoctl && chmod +x calicoctl && mv calicoctl /usr/local/bin

# Installing redis-cli
COPY --from=redis-builder /usr/local/bin/redis-cli /usr/local/bin/redis-cli

# Settings
ADD motd /etc/motd
ADD profile  /etc/profile

CMD ["/bin/bash","-l"]
