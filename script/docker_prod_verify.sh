#!/bin/bash
set -a
source ./.env
set +a

docker run --rm -p 4000:4000 \
-e SECRET_KEY_BASE="${SECRET_KEY_BASE}" \
-e GITHUB_API_TOKEN="${GITHUB_API_TOKEN}" \
--name kokuraex_prod \
kokuraex_prod
