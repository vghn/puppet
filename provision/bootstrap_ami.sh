#!/usr/bin/env bash
# bash <(wget -qO- https://raw.githubusercontent.com/vladgh/ans/master/bootstrap.sh) --role=myrole --appdir=/opt/myapp

# Immediately exit on error, including inside a chain of pipes.
set -o errexit
set -o nounset
set -o pipefail

# Defaults
ROLE='none'
APPDIR='/opt/app'
PUPPET_COLLECTION='pc1'
REPO='https://github.com/vladgh/ans.git'
PATH=/opt/puppetlabs/puppet/bin:/opt/puppetlabs/puppet/bin:$PATH
TMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')
DISTRIBUTION=$(lsb_release -cs)

# Check if command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}
# APT install package
apt_install(){ sudo apt-get -qy install "$@" < /dev/null ;}

# Parse command line arguments
for var in "$@"; do
  if [[ "$var" =~ --role=.* ]]; then
    ROLE=${var//--role=/}
  elif [[ "$var" =~ --appdir=.* ]]; then
    APPDIR=${var//--appdir=/}
  fi
done

# Install Puppet release package
echo 'Installing Puppet release package'
remote_deb="puppetlabs-release-${PUPPET_COLLECTION}-${DISTRIBUTION}.deb"
local_deb="${TMPDIR}/${remote_deb}"
wget -qO "$local_deb" "https://apt.puppetlabs.com/${remote_deb}"
sudo dpkg -i "$local_deb"

# Install GIT official Launchpad PPA repository
echo 'Adding the official Launchpad repository for GIT'
sudo add-apt-repository -y 'ppa:git-core/ppa'

# Update/upgrade system
sudo apt-get -qy update < /dev/null
sudo apt-get -qy dist-upgrade < /dev/null

# Install packages
sudo apt-get -qy install \
  git \
  puppet-agent \
  python-software-properties \
  python-pip \
  python-dev \
  libssl-dev \
  libffi-dev \
  wget \
  software-properties-common < /dev/null

# Upgrade PIP and install AWS CLI
sudo -H pip install --upgrade \
  pip setuptools pyopenssl ndg-httpsclient pyasn1 awscli

# Install r10k
echo 'Installing r10k'
puppet resource package r10k ensure=latest provider=puppet_gem

# Get application
git clone "$REPO" "$APPDIR"

# Arrange puppet files


# Install modules
echo 'Installing Puppet modules'
PUPPETFILE="${APPDIR}/puppet/Puppetfile" \
PUPPETFILE_DIR=/etc/puppetlabs/code/modules \
r10k puppetfile install --verbose

# Get private data (skip if no access)
echo 'Get private data'
bash "${APPDIR}/scripts/get_secrets.sh" || true

# Apply Puppet
echo 'Apply Puppet'
FACTER_APPDIR=${APPDIR} puppet apply \
  --detailed-exitcodes \
  --verbose \
  --hiera_config "${APPDIR}/puppet/hiera.yaml" \
  --modulepath "${APPDIR}/puppet/modules:/etc/puppetlabs/code/modules" \
  "${APPDIR}/puppet/manifests/site.pp"

echo "Bootstrap finished at $(/bin/date "+%F %T")"

