FROM alpine:3.3
MAINTAINER brad@influitive.com

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

RUN apk update && apk upgrade \
    && apk add libxml2 libxslt libevent libffi glib ncurses readline \
    openssl yaml zlib curl libpq ruby ruby-io-console \
    ruby-bundler ruby-bigdecimal ruby-irb ruby-json ruby-rake \
    libstdc++ tzdata postgresql-client ca-certificates \
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
