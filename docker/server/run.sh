#!/usr/bin/env bash
# Starts Puppet Server

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

log(){
  echo "[$(date "+%Y-%m-%dT%H:%M:%S%z") - $(hostname)] ${*}"
}

bye() {
  log 'Exit detected'; exit "${1:-0}"
}

trap 'bye $?' HUP INT QUIT TERM

until [ -s /var/local/deployed_r10k ]; do
  log "Waiting for r10k"; sleep 5
done

log 'Starting Puppet Server'
/entrypoint.sh puppetserver foreground
