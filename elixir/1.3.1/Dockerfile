FROM msaraiva/elixir:1.3.1

RUN apk add --update erlang-inets \
                     erlang-ssl \
                     erlang-crypto \
                     erlang-public-key \
                     erlang-asn1 \
                     postgresql-client \
                     postgresql

RUN mix local.hex --force
