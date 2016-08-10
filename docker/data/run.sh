#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

log()   { echo "[$(date "+%Y-%m-%dT%H:%M:%S%z") - $(hostname)] ${*}" ;}
bye()   { log 'Exit detected'; exit "${1:-0}" ;}
abort() { log "$@"; exit 1 ;}

download_vgs(){
  if [[ ! -s /opt/vgs/load ]]; then
    log 'Download the VGS Library'
    git clone https://github.com/vghn/vgs.git /opt/vgs
  fi
}

download_vpm(){
  if [[ ! -s /opt/vpm/envrc ]]; then
    log 'Download the Puppet control repo'
    git clone https://github.com/vghn/puppet.git /opt/vpm
  fi
}

download_vault(){
  log 'Download vault'
  if ! aws s3 sync "${VAULT_S3PATH}/" '/etc/puppetlabs/vault/' --delete; then
    abort "Could not download ${VAULT_S3PATH}"
  fi
}

download_hieradata(){
  log 'Download hieradata'
  if ! aws s3 sync "${HIERA_S3PATH}/" '/etc/puppetlabs/hieradata/' --delete; then
    abort "Could not download ${HIERA_S3PATH}"
  fi
}

deploy_r10k(){
  if [[ -s Puppetfile ]]; then
    log 'Deploy R10K'
    r10k deploy environment --puppetfile --verbose
  else
    log 'No Puppetfile was found in the current directory'; exit 1
  fi
}

main(){
  trap 'bye $?' HUP INT QUIT TERM
  mkdir -p /var/local

  download_vgs && download_vpm

  # shellcheck disable=1091
  . /opt/vpm/envrc

  if download_vault && download_hieradata; then
    date > /var/local/deployed_data
  fi
  if deploy_r10k; then
    date > /var/local/deployed_r10k
  fi
}

main "$@"
