FROM influitive/ruby:2.5.1-alpine

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
