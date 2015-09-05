#!/usr/bin/env bash
#
# REQUIRES:
# sudo apt-get -qy install wget
#
# USAGE:
# bash <(wget -qO- https://raw.githubusercontent.com/vladgh/puppet/master/provision/bootstrap.sh) --role=myrole --env=production

# Immediately exit on error, including inside a chain of pipes.
set -o errexit
set -o nounset
set -o pipefail

# VARs
ROLE='none'
ENV='production'
PUPPET_COLLECTION='pc1'
GIT_USER='vladgh'
GIT_REPO='puppet'
RAW_URL="https://raw.githubusercontent.com/${GIT_USER}/${GIT_REPO}/${ENV}"
PROVISION_URL="${RAW_URL}/provision"
PATH=/opt/puppetlabs/puppet/bin:/opt/puppetlabs/puppet/bin:$PATH
TMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')
DISTRIBUTION=$(lsb_release -cs)
SHOULD_UPDATE_APT=false
PUPPET_DIR=/etc/puppetlabs
R10K_DIR="${PUPPET_DIR}/r10k"
CODE_DIR="${PUPPET_DIR}/code"

# Parse command line arguments
for var in "$@"; do
  if [[ "$var" =~ --role=.* ]]; then
    ROLE=${var//--role=/}
  elif [[ "$var" =~ --env=.* ]]; then
    ENV=${var//--env=/}
  fi
done

# Check if command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}
# APT install package
apt_install(){ echo "Installing $*" && sudo apt-get -qy install "$@" < /dev/null ;}
apt_update() { echo 'Updating APT' && sudo apt-get -qy update < /dev/null ;}
apt_upgrade(){ echo 'Upgrading system' && sudo apt-get -qy upgrade < /dev/null ;}

# Parse command line arguments
for var in "$@"; do
  if [[ "$var" =~ --role=.* ]]; then
    ROLE=${var//--role=/}
  elif [[ "$var" =~ --appdir=.* ]]; then
    ENV=${var//--env=/}
  fi
done

# Update/upgrade system
sudo apt-get -qy update < /dev/null
sudo apt-get -qy dist-upgrade < /dev/null

# Install apt utilities
is_cmd add-apt-repository || \
  apt_install python-software-properties software-properties-common

# Install Puppet release package
if is_cmd puppet; then
  echo 'Puppet already installed'
  puppet --version
else
  echo 'Installing Puppet release package'
  remote_deb="puppetlabs-release-${PUPPET_COLLECTION}-${DISTRIBUTION}.deb"
  local_deb="${TMPDIR}/${remote_deb}"
  wget -qO "$local_deb" "https://apt.puppetlabs.com/${remote_deb}"
  sudo dpkg -i "$local_deb"
  SHOULD_UPDATE_APT=true
fi

# Install GIT official Launchpad PPA repository
if [ ! -s "/etc/apt/sources.list.d/git-core-ppa-${DISTRIBUTION}.list" ]; then
  echo 'Adding the official Launchpad repository for GIT'
  sudo add-apt-repository -y 'ppa:git-core/ppa'
  SHOULD_UPDATE_APT=true
fi

# Install packages (update APT if necessary)
$SHOULD_UPDATE_APT && apt_update
apt_install \
  git \
  puppet-agent \
  python-pip \
  python-dev \
  libssl-dev \
  libffi-dev \
  curl

# Upgrade PIP and install AWS CLI
echo 'Installing PIP packages'
sudo -H pip install --upgrade \
  pip setuptools pyopenssl ndg-httpsclient pyasn1 awscli

# Install r10k
echo 'Installing r10k'
is_cmd r10k || puppet resource package r10k ensure=latest provider=puppet_gem

# Get initial Puppet configuration
echo 'Get initial Puppet configuration'
mkdir -p "${CODE_DIR}"
mkdir -p "${R10K_DIR}"
wget -O "${CODE_DIR}/hiera.yaml" "${PROVISION_URL}/hiera.yaml"
wget -O "${R10K_DIR}/r10k.yaml" "${PROVISION_URL}/r10k.yaml"
wget -O "${R10K_DIR}/postrun.sh" "${PROVISION_URL}/r10k_postrun.sh"

# R10K Deployment
echo 'Deploy R10k environments'
r10k deploy environment --puppetfile --verbose

# Apply Puppet
echo 'Apply Puppet'
puppet apply \
  --detailed-exitcodes \
  --verbose \
  --environment="${ENV}" \
  "${CODE_DIR}/environments/${ENV}/manifests/site.pp"

echo "Bootstrap finished at $(/bin/date "+%F %T")"
