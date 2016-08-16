#!/usr/bin/env bash

# shellcheck disable=1091
. /opt/vpm/envrc

# VARs
env="${RACK_ENV:-}"
port="${RACK_PORT:-}"
key="${RACK_SSL_KEY:-}"
crt="${RACK_SSL_CRT:-}"
ca="${RACK_SSL_CA:-}"

# Generate self signed certificate
if [[ -z "$key" ]] && [[ -z "$crt" ]] && [[ -z "$ca" ]]; then
  key=/var/local/key.pem
  crt=/var/local/crt.pem
  ca=/var/local/crt.pem
  bind_param="ssl://0.0.0.0:${port}?key=${key}&cert=${crt}"

  if [[ ! -s /var/local/key.pem ]]; then
    openssl req -x509 \
      -newkey rsa:2048 \
      -keyout "$key" \
      -out "$crt" \
      -days 365 \
      -nodes \
      -subj '/CN=*/O=VGH/C=US'
  fi
else
  bind_param="ssl://0.0.0.0:${port}?key=${key}&cert=${crt}&verify_mode=none&ca=${ca}"
fi

# Start server
bundle exec puma \
  --environment "$env" \
  --bind "$bind_param"
