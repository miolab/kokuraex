FROM elixir:1.12.1-slim

WORKDIR /usr/src/app

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y \
  build-essential \
  curl \
  git \
  gzip \
  inotify-tools \
  ssh \
  sudo \
  tar

RUN mix local.hex --force && \
  mix local.rebar --force

RUN apt-get clean
