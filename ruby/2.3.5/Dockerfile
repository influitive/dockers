FROM ruby:2.3.5-slim

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client \
    dnsutils \
    nano \
    && rm -rf /var/lib/apt/lists/*
