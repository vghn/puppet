#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

log(){
  echo "[$(date "+%Y-%m-%dT%H:%M:%S%z") - $(hostname)] ${*}"
}

bye() {
  log 'Exit detected'; exit "${1:-0}"
}

deploy_r10k(){
  log 'Deploy R10K'
  ( cd /opt/vpm && r10k deploy environment --puppetfile --verbose )
}

main(){
  trap 'bye $?' HUP INT QUIT TERM
  mkdir -p /var/local
  if deploy_r10k; then date > /var/local/deployed_r10k; fi
}

main "$@"
