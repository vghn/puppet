#!/usr/bin/env bash
# This script installs and configures Puppet
# USAGE:
#   export ENV=production
#   wget -qO- "https://raw.githubusercontent.com/vladgh/puppet/${ENV}/provision/bootstrap.sh" | bash

set -e

# VARs
ENV=${ENV:-production}

# Load Functions
echo 'Loading remote functions'
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true

# Install packages
load_remote_scripts aws git puppet
aws_install_cli
git_install_latest
puppet_install_agent
puppet='/opt/puppetlabs/bin/puppet'

# Initial resources
$puppet resource service puppet ensure=stopped enable=false
$puppet resource service mcollective ensure=stopped enable=false
$puppet resource package r10k ensure=latest provider=puppet_gem
r10k='/opt/puppetlabs/puppet/bin/r10k'

# Get configuration files
echo 'Getting r10k and hiera configurations'
provision="https://raw.githubusercontent.com/vladgh/puppet/${ENV}/provision"
mkdir -p /etc/puppetlabs/{code,r10k}
wget -O /etc/puppetlabs/r10k/r10k.yaml "${provision}/r10k.yaml"
wget -O /etc/puppetlabs/code/hiera.yaml "${provision}/hiera.yaml"

# Deploy Puppet environments
$r10k deploy environment --puppetfile --verbose

# Apply Puppet
$puppet apply "/etc/puppetlabs/code/environments/${ENV}/manifests/site.pp" \
  --environment "$ENV"

# DONE
e_finish
