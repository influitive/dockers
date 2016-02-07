FROM influitive/ruby
MAINTAINER brad@influitive.com

ENV APP /usr/src/app

RUN mkdir -p $APP
WORKDIR $APP

ONBUILD COPY Gemfile* $APP/

ONBUILD RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    libssl1.0 libxml2-dev libxslt-dev libbz2 libevent-dev libffi-dev glib-dev ncurses-dev readline-dev yaml-dev zlib-dev \
    postgresql-dev libc-dev linux-headers && \
    bundle install --without development test --jobs 5 && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ONBUILD COPY . $APP
