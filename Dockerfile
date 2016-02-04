FROM haproxy:1.6

RUN apt-get update && apt-get install -y net-tools && \
    rm -rf /var/lib/apt/lists/* && \
    adduser haproxy --gecos "" --disabled-password && \
    mkdir -p /run/haproxy && \
    chown -R haproxy:haproxy /run/haproxy && \
    mkdir -p /etc/haproxy

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY error_pages/html /etc/haproxy/errors
RUN chown -R haproxy:haproxy /etc/haproxy

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]