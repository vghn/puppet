#!/usr/bin/env bash
set -e

# VARs
puppet='/opt/puppetlabs/bin/puppet'
r10k='/opt/puppetlabs/puppet/bin/r10k'
provision='https://raw.githubusercontent.com/vladgh/puppet/testing/provision'

# Load Functions
echo 'Loading remote functions'
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true

# Install packages
load_remote_scripts aws git puppet
aws_install_cli
git_install_latest
puppet_install_agent;

# Initial resources
$puppet resource service puppet ensure=stopped enable=false
$puppet resource service mcollective ensure=stopped enable=false
$puppet resource package r10k ensure=latest provider=puppet_gem

# Get configuration files
wget -qO /etc/puppetlabs/r10k/r10k.yaml "${provision}/r10k.yaml"
wget -qO /etc/puppetlabs/code/hiera.yaml "${provision}/hiera.yaml"

# Deploy Puppet environments
$r10k deploy environment --puppetfile --verbose

# DONE
e_finish
