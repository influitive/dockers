
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

3. Modify the RabbitMQ configuration file to allow connections from any host (i.e. docker containers)

  ```
  # in /usr/local/etc/rabbitmq/rabbitmq-env.conf find and modify the following line
  NODE_IP_ADDRESS=0.0.0.0
  ```

  And also allow non-localhost connections for the guest user

  ```
  sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /usr/local/etc/rabbitmq/rabbitmq.config'
  ```

3. Restart your computer

4. You're done! consider installing the docker-compose aliases to make your life
   much easier when working with docker.

   Your docker containers will be available through `localhost`

## Getting Started with Docker (OSX w/ VirtualBox)

NOTE: this is the old way of developing with docker - you should use the current
approach (xhyve) unless there is a good reason.

1. Download and install the Docker toolbox from https://www.docker.com/products/docker-toolbox

2. Start a docker machine with VirtualBox:

  `docker-machine create -d virtualbox default`

3. Enable SSHFS for volume mounting, this is much faster and better with keeping your files in sync between guest and host:

  https://github.com/Atamos/docker-machine-sshfs

4. (optional) Automatically populate the docker IP at the beginning of your terminal session:

  `echo 'eval "$(docker-machine env default)"' >> ~/.bash_profile`

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
