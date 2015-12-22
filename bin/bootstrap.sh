#!/usr/bin/env bash
#
# Bootstraps puppet
#
# USAGE:
# git clone https://github.com/vladgh/puppet.git
# bash puppet/bin/bootstrap.sh
#
# Environment variables:
# PP_MASTER: [String] Can be any of the following
#   - puppet: (default) the address of the puppet master server
#             Ex: puppet.example.com
#   - none: runs in master-less mode
# PP_ROLE: [String] Declares the role of the node as a trusted fact*
# PP_SECRET: [String] Declares a shared secret as a trusted fact*
# PP_COLLECTION: [String] The puppet collection (default: 'pc3')
#
# * Trusted facts info: https://docs.puppetlabs.com/puppet/latest/reference/lang_facts_and_builtin_vars.html#trusted-facts

# DEFAULTS
PP_MASTER=${PP_MASTER:-puppet}
PP_ROLE=${PP_ROLE:-none}
PP_SECRET=${PP_SECRET:-none}
PP_COLLECTION=${PP_COLLECTION:-pc1}
PP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
PATH="/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:${PATH}"

# Immediately exit on errors
set -euo pipefail

# Check if root
is_root(){
  if [[ $EUID != 0 ]]; then
    echo 'FATAL: You need to run this as root'; exit 1
  fi
}

# Check if OS supported
os_is_supported(){
  if [[ $(uname) != Linux ]]; then
    echo 'FATAL: Only Linux is supported'; exit 1
  fi
}

# Check if command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}

# Get codename
get_release() { is_cmd lsb_release && lsb_release -cs ;}

# APT install package
apt_install(){
  echo "Installing $*"
  apt-get -qy install "$@" < /dev/null
}

# Update APT
apt_update() { echo 'Updating APT' && apt-get -qy update < /dev/null ;}

# Install Puppet release package
install_release_pkg(){
  local deb_name deb_path tempdir codename
  codename=${CODENAME:-$(get_release)}
  tempdir=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')
  deb_name="puppetlabs-release-${PP_COLLECTION}-${codename}.deb"
  deb_path="${tempdir}/${deb_name}"
  if [ ! -x /opt/puppetlabs/bin/puppet ] ; then
    if ! is_cmd wget; then
      apt_update && apt_install wget
    fi
    if ! wget -O "$deb_path" "https://apt.puppetlabs.com/${deb_name}"; then
      echo 'FATAL: Could not download the release package'; exit 1
    fi
    if [ -s "$deb_path" ]; then
      echo 'Installing Puppet release package'
      dpkg -i "$deb_path" && rm "$deb_path"
      apt_update && apt_install puppet-agent
    else
      echo 'FATAL: Could not install Puppet release package'; exit 1
    fi
  else
    echo "Puppet is already installed - version $(puppet --version)"
  fi
}

# Configure puppet
configure_puppet(){
  if [[ "$PP_MASTER" == 'none' ]] && [[ -s "${PP_DIR}/Puppetfile" ]]; then
    if ! is_cmd r10k; then
      echo 'Install R10K gem'
      puppet resource package r10k ensure=latest provider=puppet_gem
    fi
    if ! is_cmd git; then
      echo 'Install git'
      puppet resource package git ensure=latest
    fi
    echo 'Install/update puppet modules'
    r10k puppetfile install \
      --puppetfile "${PP_DIR}/Puppetfile" \
      --moduledir "${PP_DIR}/modules" \
      --verbose
  elif [[ "$PP_MASTER" != 'puppet' ]]; then
    echo "Set puppet master address - '$PP_MASTER'"
    puppet config set \
      server "$PP_MASTER" --section master
  fi
}

# Generate certificate request attributes file
generate_csr_attributes_file(){
  echo 'Generating a CSR Attributes file'
  local file='/etc/puppetlabs/puppet/csr_attributes.yaml'

  # Ensure directory is present
  local file_path; file_path=$(dirname "$file")
  [ -d "$file_path" ] && mkdir -p "$file_path"

  # Get EC4 info
  local instance_id ami_id
  instance_id="$(curl --max-time 2 -s http://169.254.169.254/latest/meta-data/instance-id || true)"
  ami_id="$(curl --max-time 2 -s http://169.254.169.254/latest/meta-data/ami-id || true)"

  # Define file template
  local epp_template; epp_template=$(cat <<'EPP'
custom_attributes:
<% if $secret != 'none' { -%>
  1.2.840.113549.1.9.7: <%= $secret %>
<% } -%>
extension_requests:
<% if $role != 'none' { -%>
  pp_role: <%= $role %>
<% } -%>
<% if $instance_id =~ /^i-/ { -%>
  pp_instance_id: <%= $instance_id %>
<% } -%>
<% if $ami_id =~ /^ami-/ { -%>
  pp_image_name: <%= $ami_id %>
<% } -%>
EPP
  )

  # Render template
  puppet epp render -e "$epp_template" \
    --values "{
      secret => '${PP_SECRET}',
      role => ${PP_ROLE},
      instance_id => '${instance_id}',
      ami_id => '${ami_id}'
    }" > "$file"
}

# Run puppet
run_puppet(){
  if [[ "$PP_MASTER" == 'none' ]]; then
    echo 'Applying puppet'
    FACTER_ROLE="${PP_ROLE}" puppet apply \
      --modulepath "${PP_DIR}/dist:${PP_DIR}/modules"  \
      "${PP_DIR}/manifests/site.pp"
  elif [[ "$PP_MASTER" != 'puppet' ]]; then
    echo 'Running puppet'
    puppet agent \
      --server "$PP_MASTER" \
      --waitforcert 5 \
      --no-daemonize \
      --onetime \
      --verbose
  else
    echo 'WARNING: No puppet master specified'
  fi
}

# Logic
main(){
  is_root && os_is_supported
  install_release_pkg
  configure_puppet
  generate_csr_attributes_file
  run_puppet
}

# Run
main

