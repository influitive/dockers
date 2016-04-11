FROM influitive/ruby
MAINTAINER brad@influitive.com

ENV APP /usr/src/app

RUN mkdir -p $APP
WORKDIR $APP

ONBUILD COPY Gemfile* $APP/

ONBUILD RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc make git \
    libpq-dev libglib2.0-dev build-essential patch zlib1g-dev liblzma-dev \
    && bundle install --without development test --jobs 5 \
      && apt-get purge -y --auto-remove \
      gcc make git \
      libpq-dev libglib2.0-dev build-essential patch zlib1g-dev liblzma-dev \
		&& rm -rf /var/lib/apt/lists/*

ONBUILD COPY . $APP
