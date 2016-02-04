FROM iron/ruby:2.2
MAINTAINER brad@influitive.com

RUN apk --update add ruby-bundler ruby-bigdecimal ruby-irb ruby-json ruby-rake \
    libstdc++ tzdata postgresql-client \
    && rm -rf /var/cache/apk/*

# Needs to match above Ruby version
ENV GEM_HOME /usr/lib/ruby/gems/2.2.0

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1 && \
    bundle config --global path "$GEM_HOME" && \
    bundle config --global bin "$GEM_HOME/bin" && \
    bundle config --global silence_root_warning true && \
    bundle config build.nokogiri --use-system-libraries

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

ENV APP /usr/src/app

RUN mkdir -p $APP
WORKDIR $APP

ONBUILD COPY Gemfile* $APP/

ONBUILD RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    libssl1.0 libxml2-dev libxslt-dev libbz2 libevent-dev libffi-dev glib-dev ncurses-dev readline-dev yaml-dev zlib-dev \
    postgresql-dev libc-dev linux-headers && \
    bundle install --without development test --jobs 3 && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ONBUILD COPY . $APP
