#!/usr/bin/env bash
# This script installs and configures Puppet
# USAGE:
#   wget -qO- "https://raw.githubusercontent.com/vladgh/puppet/production/provision/bootstrap.sh" | bash

# Immediately exit on error, including inside a chain of pipes.
set -o errexit
set -o nounset
set -o pipefail

# VARs
ENV="${ENV:-production}"
PATH=/opt/puppetlabs/puppet/bin:$PATH
PROVISION_URL="https://raw.githubusercontent.com/vladgh/puppet/${ENV}/provision"
PUPPET_COLLECTION='pc1'
TMP_DIR="$(mktemp -d /tmp/puppet_bootstrap.XXXXX)"
PUPPET_DEB="puppetlabs-release-${PUPPET_COLLECTION}-$(lsb_release -cs).deb"
PUPPET_DIR="/etc/puppetlabs"
should_apt_update=false
packages=

# Common functions
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}
apt_install(){ sudo apt-get -qy install "$@" < /dev/null ;}
apt_update(){ sudo apt-get -qy update < /dev/null ;}

# Install Puppet release package
if [ ! -s /etc/apt/sources.list.d/puppetlabs-${PUPPET_COLLECTION}.list ]; then
  echo 'Installing Puppet release package'
  wget -qO "${TMP_DIR}/${PUPPET_DEB}" "https://apt.puppetlabs.com/${PUPPET_DEB}"
  sudo dpkg -i "${TMP_DIR}/${PUPPET_DEB}"
  should_apt_update=true
  packages="$packages puppet-agent"
else
  echo 'The Puppet release package is already installed'
fi

# Install GIT from the official Launchpad PPA repository
if [ ! -s /etc/apt/sources.list.d/git-core-ppa-trusty.list ]; then
  if ! is_cmd add-apt-repository; then
    echo 'Installing APT utilities'
    apt_update
    apt_install python-software-properties software-properties-common
  fi
  echo 'Adding the official Launchpad repository for GIT'
  sudo add-apt-repository -y 'ppa:git-core/ppa'
  should_apt_update=true
  packages="$packages git"
else
  echo 'The official Launchpad repository for GIT is already set up'
fi

# Check if Python PIP is installed
if ! is_cmd pip; then
  should_apt_update=true
  packages="$packages python-pip"
fi

# Update APT if necessary
$should_apt_update && apt_update

# Install essential packages
# shellcheck disable=SC2086
[ -z "$packages" ] || apt_install $packages

# Install AWS Command Line Tools
if ! is_cmd aws; then
  echo 'Installing AWS CLI'
  sudo -H pip install --upgrade awscli
else
  echo 'AWS CLI is already installed'
fi

# Install essential gems
for pgem in r10k aws-sdk; do
  if ! is_cmd $pgem; then
    echo "Installing the '$pgem' gem"
    puppet resource package $pgem ensure=latest provider=puppet_gem
  fi
done

# Create directories
echo 'Creating Puppet directories'
mkdir -p ${PUPPET_DIR}/{code/private,r10k,puppet}

# Get initial configurations
echo 'Getting initial configuration files'
wget -qO "${PUPPET_DIR}/code/hiera.yaml" "${PROVISION_URL}/hiera.yaml"
wget -qO "${PUPPET_DIR}/r10k/r10k.yaml" "${PROVISION_URL}/r10k.yaml"
wget -qO "${PUPPET_DIR}/r10k/r10k_postrun.sh" "${PROVISION_URL}/r10k/postrun.sh"

# Deploy Puppet environments
echo 'Deploying Puppet environment'
r10k deploy environment --puppetfile --verbose

# Apply Puppet
echo 'Applying Puppet'
puppet apply \
  --environment "$ENV" \
  --detailed-exitcodes \
  --verbose \
  "/etc/puppetlabs/code/environments/${ENV}/manifests/site.pp"

# Done
echo "Finished ${BASH_SOURCE[0]} at $(/bin/date "+%F %T")"
exit 0

