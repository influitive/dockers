
# Docker README

## Getting Started with Docker (OSX w/ VirtualBox)

1. Download and install the Docker toolbox from https://www.docker.com/products/docker-toolbox

2. Start a docker machine with VirtualBox:

  `docker-machine create -d virtualbox default`

3. Enable SSHFS for volume mounting, this is much faster and better with keeping your files in sync between guest and host:

  https://github.com/Atamos/docker-machine-sshfs

4. (optional) Automatically populate the docker IP at the beginning of your terminal session:

  `echo 'eval "$(docker-machine env default)"' >> ~/.bash_profile`

5. (optional) Install aliases to make your life much easier:

  ```bash
  # insert the following into your ~/.bash_aliases file
  # feel free to add your own and consider contributing it
  alias dc='docker-compose '
  alias dc-run='dc run --rm '

  alias web-run='dc-run web '
  alias web-bundle='web-run bundle '
  alias web-rails='web-bundle exec rails '
  alias web-rake='web-bundle exec rake '
  alias web-rspec='web-bundle exec rspec '
  ```

## Getting Started with Docker (OSX w/ xhyve)

__Coming Soon with the new docker beta!__
