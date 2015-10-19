#!/usr/bin/env bash
#
# Puppet apply script. It gets all modules an configuration files with r10k and
# applies the main manifest.
#
# USAGE:
# bash bin/puppet_apply.sh --env=dev

# Immediately exit on errors
set -euo pipefail

# DEFAULTS
ENVIRONMENT='production'

# Parse command line arguments
for var in "$@"; do
  if [[ "$var" =~ --env=.* ]]; then
    ENVIRONMENT=${var//--env=/}
  fi
done

# Deploy R10K environaments
echo 'Deploy R10k environments'
sudo /opt/puppetlabs/puppet/bin/r10k deploy environment \
  --puppetfile --verbose --color

# Apply main Puppet manifest
echo 'Apply main Puppet manifest'
sudo /opt/puppetlabs/bin/puppet apply --verbose --environment="${ENVIRONMENT}" \
  "$(sudo /opt/puppetlabs/bin/puppet config print \
  --environment="${ENVIRONMENT}" manifest)/site.pp"

