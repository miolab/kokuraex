FROM elixir:1.16.2-slim AS build

ENV MIX_HOME=/root/.mix \
  MIX_ENV=prod \
  PHX_SERVER=true \
  SECRET_KEY_BASE=${SECRET_KEY_BASE} \
  PORT=${PORT}

COPY . /usr/src/app
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

RUN apt-get clean

RUN mix local.hex --force && \
  mix local.rebar --force

RUN mix archive.install hex phx_new 1.7.11 --force

RUN mix deps.get --only prod
RUN MIX_ENV=prod mix deps.compile
RUN MIX_ENV=prod mix assets.deploy
RUN MIX_ENV=prod mix release --overwrite

FROM elixir:1.16.2-slim AS app

ENV HOME=/app \
  PHX_SERVER=true

WORKDIR /app
RUN chown nobody:nogroup /app

USER nobody:nogroup

COPY --from=build --chown=nobody:nogroup /usr/src/app/_build/prod/rel/kokuraex ./

CMD [ "bin/kokuraex", "start" ]
