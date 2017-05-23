FROM        alpine:3.5
MAINTAINER  reza@influitive.com

ARG PROMETHEUS_VERSION=1.6.3

RUN apk add --update curl bash

# Download the prometheus tarball to /tmp/prometheus.tar.gz
RUN curl -fLsS \
         --retry 20 \
         -Y 100000 \
         -y 60 \
         https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz \
         -o /tmp/prometheus.tar.gz

# Extract and destroy the downloaded tarball to /tmp/prometheus
RUN mkdir -p /tmp/prometheus

RUN tar xvf /tmp/prometheus.tar.gz --strip-components=1 -C /tmp/prometheus

RUN rm /tmp/prometheus.tar.gz

# move the binaries to /usr/local/bin
RUN cp /tmp/prometheus/prometheus /usr/local/bin/prometheus
RUN cp /tmp/prometheus/promtool /usr/local/bin/promtool

# move the console_libraries/ and consoles/ folders to /usr/share/prometheus
RUN mkdir -p /usr/share/prometheus

RUN cp -r /tmp/prometheus/console_libraries/ /usr/share/prometheus/console_libraries
RUN cp -r /tmp/prometheus/consoles/ /usr/share/prometheus/consoles/

# copy the prometheus configuration file (at least the base of it) into /etc/prometheus
RUN mkdir -p /etc/prometheus

COPY prometheus.yml /etc/prometheus/prometheus.yml

# add the runner script to the image
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 9090

VOLUME [ "/prometheus" ]

WORKDIR /prometheus

CMD ["/run.sh"]
