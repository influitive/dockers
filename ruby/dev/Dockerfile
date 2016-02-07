FROM influitive/ruby
MAINTAINER brad@influitive.com

RUN apk update && apk upgrade

RUN apk add curl git make
RUN apk add openssl-dev libssl1.0 build-base libxml2-dev libxslt-dev libbz2 libevent-dev libffi-dev glib-dev ncurses-dev readline-dev yaml-dev zlib-dev
RUN apk add libpq sqlite-dev mariadb-libs postgresql-dev
RUN apk add ruby-dev ruby ruby-io-console ruby-bundler

# From
# https://github.com/mhart/alpine-node/blob/63875c1f173b7f38e7bca1aaaf20042ee71c5263/Dockerfile
ENV NODE_VERSION=v5.5.0 NPM_VERSION=3

RUN apk add --update curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -xz && \
  cd /node-${NODE_VERSION} && \
  ./configure --prefix=/usr ${CONFIG_FLAGS} && \
  make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make install && \
  paxctl -cm /usr/bin/node && \
  cd / && \
  if [ -x /usr/bin/npm ]; then \
    npm install -g npm@${NPM_VERSION} && \
    find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
  fi && \
  apk del curl make gcc g++ binutils-gold python linux-headers paxctl ${DEL_PKGS} && \
  rm -rf /etc/ssl /node-${NODE_VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

# Clean APK cache
RUN rm -rf /var/cache/apk/*

# CA CERT fix for curl over ssl
RUN mkdir -p /etc/ssl/certs/ && update-ca-certificates --fresh
# http://fabiorehm.com/blog/2015/07/22/building-a-minimum-viable-phantomjs-2-docker-image/
RUN curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
      | tar xz -C /
