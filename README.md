# Docker README


## Getting Started with Docker (OSX w/ xhyve)

1. Download Docker for OSX  from https://docs.docker.com/engine/installation/mac/

2. Install an alias for your host machine's local loopback network interface.  This
   allows the docker containers to communicate with the host machine on the
   specified ip address.

   Create the following file at `/usr/local/bin/login-script`:
   ```
   #!/bin/sh

   # add a local loopback alias for docker
   ifconfig lo0 alias 10.0.2.2
   ```

   Then run the following commands:
   ```
   sudo chmod +x /usr/local/bin/login-script
   sudo defaults write com.apple.loginwindow LoginHook /usr/local/bin/login-script
   ```

3. Modify the RabbitMQ/Mongo configuration files to allow connections from any host (i.e. docker containers)

  ```
  # in /usr/local/etc/rabbitmq/rabbitmq-env.conf find and modify the following line
  NODE_IP_ADDRESS=0.0.0.0
  ```

  And also allow non-localhost connections for the guest user

  ```
  sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /usr/local/etc/rabbitmq/rabbitmq.config'
  sed -i .bak "s/bindIp: .*/bindIp: 0.0.0.0/" /usr/local/etc/mongod.conf
  sed -i .bak "s/^bind 127.0.0.1$/bind 127.0.0.1 10.0.2.2/" /usr/local/etc/redis.conf
  grep -q 10.0.2.2 /usr/local/var/postgres/pg_hba.conf || echo 'host all all 10.0.2.2/32 trust' >> /usr/local/var/postgres/pg_hba.conf
  sed -i .bak "s/^listen_addresses = 'localhost'/list_addresses = 'localhost,10.0.2.2'/" /usr/local/var/postgres/postgresql.conf
  ```

3. Restart your computer

4. You're done! consider installing the docker-compose aliases to make your life
   much easier when working with docker.

   Your docker containers will be available through `localhost`

## Install aliases to make your life much easier

Insert the following into your `~/.bash_aliases` file feel free to add your own
and consider contributing it.

```bash
alias dc='docker-compose '
alias dc-run='dc run --rm '

alias web-run='dc-run web '
alias web-bundle='web-run bundle '
alias web-rails='web-bundle exec rails '
alias web-rake='web-bundle exec rake '
alias web-rspec='web-bundle exec rspec '
```

## Building new images

Depending on the image you're updating, you may have 1 or 2 steps to go through. If you're modifying a `base` image, that is, an image that *other* images use, you'll need to re-publish the base image AND images that use that base image. If you're just modifying an end-user image, you can just update and publish that one.

#### Modifying a base image

1. Commit and PR your changes
2. in the base image directory (eg `/ruby`) run `docker build -t influitive/ruby .`
3. Push that base image using `docker push influitive/ruby`.

This will push up `influitive/ruby:latest`.

Note that other images that have already been built with the *previous* `influitive/ruby` image as their `FROM` will now need to be updated also (if they want those changes). To do this,

#### Modifying an image that *uses* a base image

1. go into the appropriate folder of the image you want to modify (eg, `onbuild` or `dev`)
2. rebuild the tagged image using the new base image `docker build -t influitive/ruby:onbuild .`
3. re-tag any other matching tags (such as the ruby version tag) `docker build -t influitive/ruby:onbuild-2.3`
4. push any tagged images up using `docker push influitive/ruby:onbuild-2.3` for each tagged image
