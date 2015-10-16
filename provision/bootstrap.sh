#!/usr/bin/env bash
#
# This scripts installs the latest Puppet Agent.
#
# wget -qO- https://raw.githubusercontent.com/vladgh/puppet/master/provision/puppet.sh | bash

# Immediately exit on errors
set -euo pipefail

# START ########################################################################
echo "Puppet install script started at $(/bin/date "+%F %T")"

# DEFAULTS #####################################################################
COLLECTION='pc1'
PATH=/opt/puppetlabs/puppet/bin:/opt/puppetlabs/puppet/bin:$PATH
TMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')

# FUNCTIONS ####################################################################

## Command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}

## Release is Ubuntu
is_ubuntu() { is_cmd lsb_release && [[ "$(lsb_release -si)" =~ Ubuntu ]] ;}

## Get codename
codename() { is_cmd lsb_release && lsb_release -cs ;}

## Update APT
apt_update() { echo 'Updating APT' && sudo apt-get -qy update < /dev/null ;}

## Install package
apt_install() {
  apt_update
  echo "Installing $*" && sudo apt-get -qy install "$@" < /dev/null
}

## Upgrade system
apt_upgrade() {
  apt_update
  echo 'Upgrading system' && sudo apt-get -qy upgrade < /dev/null
}

# INSTALL PUPPET  ##############################################################

## Make sure wget is installed (even though it should be, if we execute this
## remotely)
is_cmd wget || apt_install wget

## Make sure we can add the repository
is_cmd add-apt-repository || \
  apt_install python-software-properties software-properties-common

## Install Puppet release package
if is_cmd puppet; then
  echo 'Puppet already installed'
  puppet --version
else
  echo 'Installing Puppet release package'
  debname="puppetlabs-release-${COLLECTION}-$(codename).deb"
  debfile="${TMPDIR}/${debname}"
  wget -qO "$debfile" "https://apt.puppetlabs.com/${debname}"
  sudo dpkg -i "$debfile"
  apt_install puppet-agent
fi

# FINISH #######################################################################
echo "Puppet install script finishedat $(/bin/date "+%F %T")"

