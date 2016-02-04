FROM haproxy:1.6

RUN apt-get update && apt-get install -y net-tools && \
    rm -rf /var/lib/apt/lists/* && \
    adduser haproxy --gecos "" --disabled-password && \
    mkdir -p /run/haproxy && \
    chown -R haproxy:haproxy /run/haproxy

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]