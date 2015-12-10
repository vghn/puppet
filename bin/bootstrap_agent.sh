#!/usr/bin/env bash
#
# VGH bootstrap script
#
# USAGE:
# git clone https://github.com/vladgh/puppet.git
# bash puppet/bin/bootstrap_agent.sh [args]
#
# Command line arguments:
# --role=myrole -> declares the role of the node as a trusted fact*
# --aws         -> adds the instance and ami ids as a trusted fact
#
# * Trusted facts info: https://docs.puppetlabs.com/puppet/latest/reference/lang_facts_and_builtin_vars.html#trusted-facts

# Immediately exit on errors
set -euo pipefail

# DEFAULTS
PUPPET_MASTER='puppet.vladgh.com'
ROLE='none'
AWS=false

# Parse command line arguments
for var in "$@"; do
  if [[ "$var" =~ --role=.* ]]; then
    ROLE=${var//--role=/}
  elif [[ "$var" =~ --aws ]]; then
    AWS=true
  fi
done

# Check if it's a Linux machine
if [[ $(uname) != Linux ]]; then
  echo 'FATAL: Only Linux is supported'; exit 1
fi

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
# The Puppet collection
PUPPET_COLLECTION='pc1'
# Allow overriding the distribution codename
CODENAME=${CODENAME:-$(get_release)}
# Create temporary directory
TEMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')

# Install Puppet release package
if [[ ! -x /opt/puppetlabs/bin/puppet ]] ; then
  debname="puppetlabs-release-${PUPPET_COLLECTION}-${CODENAME}.deb"
  debfile="${TEMPDIR}/${debname}"
  if is_cmd wget; then
    if ! wget -qO "$debfile" "https://apt.puppetlabs.com/${debname}"; then
      echo 'FATAL: Could not download the release package'; exit 1
    fi
  else
    apt_update && apt_install wget
  fi
  if [ -s "$debfile" ]; then
    echo 'Installing Puppet release package'
    sudo dpkg -i "$debfile" && rm "$debfile"
    apt_update && apt_install puppet-agent
  else
    echo 'FATAL: Could not install Puppet release package'; exit 1
  fi
else
  echo 'WARNING: Puppet is already installed.'
fi

# Write CSR attributes to file
echo 'Creating a CSR Attributes file'
# Ensure directory is present
[ -d /etc/puppetlabs/puppet ] && mkdir -p /etc/puppetlabs/puppet
# Start by writing the role
cat > /etc/puppetlabs/puppet/csr_attributes.yaml <<YAML
extension_requests:
  pp_role: $PP_ROLE
YAML
# Get Instance and AMI IDs
if [ "$AWS" = true ]; then
  # Append to the previous file
  cat >> /etc/puppetlabs/puppet/csr_attributes.yaml <<YAML
  pp_instance_id: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)
  pp_image_name: $(curl -s http://169.254.169.254/latest/meta-data/ami-id)
YAML
fi
