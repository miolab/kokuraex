FROM elixir:1.11.3-slim

ENV MIX_HOME=/root/.mix

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
RUN mix archive.install hex serum_new --force

RUN apt-get clean

COPY . /usr/src/app/
# COPY ./kokuraex/mix.exs /usr/src/app/kokuraex/mix.exs

WORKDIR /usr/src/app/kokuraex
RUN mix deps.get
RUN mix deps.compile

CMD [ "mix", "serum.server" ]
