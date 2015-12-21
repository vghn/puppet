#!/usr/bin/env bash
#
# Installs puppet agent
#
# USAGE:
# git clone https://github.com/vladgh/puppet.git
# bash puppet/bin/bootstrap_agent.sh
#
# Environment variables:
# PP_SERVER: [String] The address of the puppet master (default: 'puppet')
# PP_ROLE: [String] Declares the role of the node as a trusted fact*
# PP_SECRET: [String] Declares a shared secret as a trusted fact*
# PP_COLLECTION: [String] The puppet collection (default: 'pc1')
#
# * Trusted facts info: https://docs.puppetlabs.com/puppet/latest/reference/lang_facts_and_builtin_vars.html#trusted-facts

# DEFAULTS
PP_SERVER=${PP_SERVER:-puppet}
PP_ROLE=${PP_ROLE:-none}
PP_SECRET=${PP_SECRET:-none}
PP_COLLECTION=${PP_COLLECTION:-pc1}

# Immediately exit on errors
set -euo pipefail

# Check if OS supported
os_is_supported(){
  if [[ $(uname) != Linux ]]; then
    echo 'FATAL: Only Linux is supported'; return 1
  fi
}

# Check if command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}

# Get codename
get_release() { is_cmd lsb_release && lsb_release -cs ;}

# APT install package
apt_install(){
  echo "Installing $*"
  sudo apt-get -qy install "$@" < /dev/null
}

# Update APT
apt_update() { echo 'Updating APT' && sudo apt-get -qy update < /dev/null ;}

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
      echo 'FATAL: Could not download the release package'; return 1
    fi
    if [ -s "$deb_path" ]; then
      echo 'Installing Puppet release package'
      sudo dpkg -i "$deb_path" && rm "$deb_path"
      apt_update && apt_install puppet-agent
    else
      echo 'FATAL: Could not install Puppet release package'; exit 1
    fi
  else
    echo 'INFO: Puppet is already installed.'
  fi
}

# Configure puppet
configure_puppet(){
  if [ "$PP_SERVER" != 'puppet' ]; then
    echo "Set puppet master ('$PP_SERVER')"
    sudo /opt/puppetlabs/bin/puppet config set \
      server "$PP_SERVER" --section master
  fi
}

# Generate certificate request attributes file
generate_csr_attributes_file(){
  echo 'Generating a CSR Attributes file'
  local file='/etc/puppetlabs/puppet/csr_attributes.yaml'

  # Ensure directory is present
  local path; path=$(dirname "$file")
  [ -d "$path" ] && mkdir -p "$path"

  # Get EC2 info
  local instance_id ami_id
  instance_id="$(curl -s http://169.254.169.254/latest/meta-data/instance-id >/dev/null 2>&1 || true)"
  ami_id="$(curl -s http://169.254.169.254/latest/meta-data/ami-id >/dev/null 2>&1 || true)"

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
  /opt/puppetlabs/bin/puppet epp render -e "$epp_template" \
    --values "{
      secret => '${PP_SECRET}',
      role => ${PP_ROLE},
      instance_id => '${instance_id}',
      ami_id => '${ami_id}'
    }" > "$file"
}

# Logic
main(){
  os_is_supported
  install_release_pkg
  configure_puppet
  generate_csr_attributes_file
}

# Run
main

