#!/usr/bin/env bash
#
# VGH bootstrap script
#
# USAGE:
# bash <(wget -qO- https://raw.githubusercontent.com/vladgh/puppet/master/bin/bootstrap_agent.sh)

# DEFAULTS
COLLECTION='pc1'

# Wrap the entire script inside a function to make sure that, when piped, it's
# retrieved completely
bootstrap(){

# Immediately exit on errors
set -euo pipefail

# FUNCTIONS
# Check if command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}
# Get codename
get_release() { is_cmd lsb_release && lsb_release -cs ;}
# APT install package
apt_install(){ echo "Installing $*" && sudo apt-get -qy install "$@" < /dev/null ;}
# Update APT
apt_update() { echo 'Updating APT' && sudo apt-get -qy update < /dev/null ;}

# VARs
# Allow overriding the distribution codename
CODENAME=${CODENAME:-$(get_release)}
# Create temporary directory
TEMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')

# Install Puppet release package
if [[ ! -x /opt/puppetlabs/bin/puppet ]] ; then
  debname="puppetlabs-release-${COLLECTION}-${CODENAME}.deb"
  debfile="${TEMPDIR}/${debname}"
  if is_cmd wget; then
    if ! wget -qO "$debfile" "https://apt.puppetlabs.com/${debname}"; then
      echo 'Could not download the release package'; exit 1
    fi
  else
    apt_update && apt_install wget
  fi
  if [ -s "$debfile" ]; then
    echo 'Installing Puppet release package'
    sudo dpkg -i "$debfile" && rm "$debfile"
    apt_update && apt_install puppet-agent
  else
    echo 'Could not install Puppet release package'; exit 1
  fi
else
  echo 'Puppet is already installed.'
fi

} # end bootstrap function

# RUN
bootstrap "$@"

