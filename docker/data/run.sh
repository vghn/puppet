#!/usr/bin/env bash

# shellcheck disable=1091
. /opt/vpm/envrc

# Generate self signed certificate
if [[ -z "${RACK_SSL_KEY:-}" ]] &&  [[ -z "${RACK_SSL_CRT:-}" ]]; then
  if [[ ! -s /var/local/key.pem ]]; then
    export RACK_SSL_KEY=/var/local/key.pem
    export RACK_SSL_CRT=/var/local/crt.pem
    openssl req -x509 \
      -newkey rsa:2048 \
      -keyout "$RACK_SSL_KEY" \
      -out "$RACK_SSL_CRT" \
      -days 365 \
      -nodes \
      -subj '/CN=*/O=VGH/C=US'
  fi
fi

# Start server
bundle exec puma \
  --environment "$RACK_ENV" \
  --bind "ssl://0.0.0.0:${RACK_PORT}?key=${RACK_SSL_KEY}&cert=${RACK_SSL_CRT}"
