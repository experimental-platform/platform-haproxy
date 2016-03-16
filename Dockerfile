FROM haproxy:1.6

RUN apt-get update && apt-get install -y net-tools openssl && \
    rm -rf /var/lib/apt/lists/* && \
    addgroup haproxy --gid 600 && \
    adduser haproxy --gecos "" --disabled-password --uid 600 --gid 600 && \
    mkdir -p /run/haproxy && \
    chown -R haproxy:haproxy /run/haproxy && \
    mkdir -p /etc/haproxy && \
    mkdir -p /data/ssl && \
    chown -R haproxy:haproxy /data/ssl

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY error_pages/html /etc/haproxy/errors
RUN chown -R haproxy:haproxy /etc/haproxy

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]