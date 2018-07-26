FROM haproxy:alpine

ENV LISTEN_PORT 443
ENV LE_PORT 9876

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]