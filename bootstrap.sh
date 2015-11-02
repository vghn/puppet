#!/usr/bin/env bash
#
# VGH bootstrap script
#
# USAGE:
# bash <(wget -qO- https://raw.githubusercontent.com/vladgh/puppet/master/bootstrap.sh) --role=myrole --env=mybranch

# DEFAULTS
ROLE='none'
ENVIRONMENT='production'
PUPPET_COLLECTION='pc1'
GITHUB_REPO='vladgh/puppet'

# Wrap the entire script inside a function to make sure that, when piped, it's
# retrieved completely
bootstrap(){

# Immediately exit on errors
set -euo pipefail

# Parse command line arguments
for var in "$@"; do
  if [[ "$var" =~ --role=.* ]]; then
    ROLE=${var//--role=/}
  elif [[ "$var" =~ --env=.* ]]; then
    ENVIRONMENT=${var//--env=/}
  fi
done

# VARs
RAWURL="https://raw.githubusercontent.com/${GITHUB_REPO}/${ENVIRONMENT}"
PUPPET='/opt/puppetlabs/bin/puppet'
R10K='/opt/puppetlabs/puppet/bin/r10k'
TEMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')

# Check if command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}
# Get codename
codename() { is_cmd lsb_release && lsb_release -cs ;}
# APT install package
apt_install(){ echo "Installing $*" && sudo apt-get -qy install "$@" < /dev/null ;}
# Update APT
apt_update() { echo 'Updating APT' && sudo apt-get -qy update < /dev/null ;}
# Install Puppet module
puppet_mod_install(){
  sudo $PUPPET module install --environment="${ENVIRONMENT}" "$@"
}
# Get Puppet config
puppet_config_print(){
  sudo $PUPPET config print --environment="${ENVIRONMENT}" "$@"
}
# Apply Puppet
puppet_apply(){
  # If apply runs with `--detailed-exitcodes`,an exit code of '0' means there
  # were no changes an exit code of '2' means there were changes, an exit code
  # of '4' means there were failures during the transaction, and an exit code
  # of '6' means there were both changes and failures.
  if sudo $PUPPET apply --verbose --environment="${ENVIRONMENT}" \
    --detailed-exitcodes "$@"; then
    echo 'Puppet run successful (no changes)'
  else
    exit_code=$?
    if [ $exit_code -eq 2 ]; then
      echo 'Puppet run successful'
    else
      echo 'Puppet run failed'
      exit $exit_code
    fi
  fi
}

# Install wget
if is_cmd wget; then
  :
else
  apt_update && apt_install wget
fi

# Install Puppet release package
if [[ ! -x /opt/puppetlabs/bin/puppet ]] ; then
  echo 'Installing Puppet release package'
  debname="puppetlabs-release-${PUPPET_COLLECTION}-$(codename).deb"
  debfile="${TEMPDIR}/${debname}"
  wget -qO "$debfile" "https://apt.puppetlabs.com/${debname}"
  if [ -s "$debfile" ]; then
    sudo dpkg -i "$debfile"
    apt_update && apt_install puppet-agent
  else
    echo 'Could not install Puppet release package'
  fi
fi

# Ensure environment directory
envpath=$(sudo /opt/puppetlabs/bin/puppet config print environmentpath)
echo "Creating '${envpath}/${ENVIRONMENT}'"
mkdir -p "${envpath}/${ENVIRONMENT}"

# Install temporary bootstrap modules
puppet_mod_install puppetlabs-apt --version 2.2.0
puppet_mod_install puppetlabs-git --version 0.4.0
puppet_mod_install zack-r10k --version 3.1.1
puppet_mod_install hunner-hiera --version 1.3.2

# Add external Facter facts
factsdir='/etc/puppetlabs/facter/facts.d'
[ -d "$factsdir" ] || sudo mkdir -p "$factsdir"
echo "role: ${ROLE}" | sudo tee "${factsdir}/role.yaml"

# Apply bootstrap manifest
echo 'Apply remote bootstrap manifest'
wget -qO- "${RAWURL}/manifests/bootstrap.pp" | puppet_apply

# Deploy R10K environaments
echo 'Deploy R10K environments'
sudo $R10K deploy environment \
  --puppetfile --verbose --color

# Apply main Puppet manifest
echo 'Apply main Puppet manifest'
manifest="$(puppet_config_print manifest)/site.pp"
puppet_apply "$manifest"

} # end bootstrap function

# RUN
bootstrap "$@"

