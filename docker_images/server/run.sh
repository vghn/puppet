#!/usr/bin/env bash
# Starts Puppet Server

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Default arguments
do_wait=false

# Process arguments
while :; do
  case "${1:-}" in
    -w | --wait)
      do_wait=true
      shift
      ;;
    --) # End of all options
      shift
      break
      ;;
    -*)
      e_abort "Error: Unknown option: ${1}"; return 1
      ;;
    *)  # No more options
      break
      ;;
  esac
done

log(){
  echo "[$(date "+%Y-%m-%dT%H:%M:%S%z") - $(hostname)] ${*}"
}

if [[ "$do_wait" == true ]]; then
  until \
    [ -s /var/local/deployed_data ] && \
    [ -s /var/local/deployed_r10k ]
  do
    log "Waiting for data"; sleep 5
  done
fi

log 'Starting Puppet Server'
/entrypoint.sh puppetserver foreground
