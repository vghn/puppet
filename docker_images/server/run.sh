#!/usr/bin/env bash
# Starts Puppet Server

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Load environment
# shellcheck disable=1091
. /opt/vpm/envrc

until \
  [ -s /var/local/deployed_data ] && \
  [ -s /var/local/deployed_r10k ]
do
  log "Waiting for data"; sleep 5
done

log 'Starting Puppet Server'
/entrypoint.sh puppetserver foreground
