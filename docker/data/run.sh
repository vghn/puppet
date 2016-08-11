#!/usr/bin/env bash

# shellcheck disable=1091
. /opt/vpm/envrc

# Generate self signed certificate
if [[ ! -s /var/local/key.pem ]]; then
  (
  cd /var/local || exit
  openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes -subj '/CN=*/O=VGH/C=US'
  )
fi

# Start server
bundle exec puma \
  --environment "$RACK_ENV" \
  --bind "ssl://0.0.0.0:${RACK_PORT}?key=/var/local/key.pem&cert=/var/local/cert.pem"
