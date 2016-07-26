#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Install/Update VGS Library
install_vgs(){
  echo 'Install/Update VGS Library'
  if [[ -d /opt/vgs/.git ]]; then
    ( cd /opt/vgs && git fetch --all && git reset --hard origin/master )
  else
    git clone https://github.com/vghn/vgs.git /opt/vgs
  fi
}

deploy_r10k(){
  log 'Deploy R10K'
  ( cd /opt/vpm && r10k deploy environment --puppetfile --verbose )
}

main(){
  install_vgs && date > /var/local/deployed_vgs

  # shellcheck disable=1091
  . /opt/vpm/envrc

  download_data && date > /var/local/deployed_data
  deploy_r10k && date > /var/local/deployed_r10k
}

main
