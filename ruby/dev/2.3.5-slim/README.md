# Docker README

This is a base image for running ruby/rails apps locally with NodeJS for assets.
We're probably going to split these images out at some point so that node is
its own running container for assets. Still a WIP

1. Make your changes
2. build image with `docker build -t influitive/ruby:dev .`
3. push image to Dockerhub with `docker push influitive/ruby:dev`
