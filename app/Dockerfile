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

RUN apt-get install -y nodejs npm
RUN npm install -g n
RUN n 14.17.0
RUN apt-get purge -y nodejs npm

RUN apt-get clean

RUN mix local.hex --force && \
  mix local.rebar --force

COPY ./mix.exs /usr/src/app/

RUN mix archive.install hex phx_new 1.5.9 --force

CMD [ "mix", "phx.server", "--no-halt" ]