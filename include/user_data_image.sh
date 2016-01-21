#!/usr/bin/env bash
# Image User Data

# Immediately exit on errors
set -euo pipefail

echo 'Updating APT'
sudo apt-get -qy update < /dev/null

echo 'Upgrade system'
sudo apt-get -qy upgrade < /dev/null

echo 'Install GIT'
sudo apt-get -qy install git < /dev/null

echo 'Download production branch of the puppet control repo'
git clone -b production https://github.com/vladgh/puppet.git /opt/puppet_control

echo 'Bootstrap puppet agent'
export PP_MASTER=none
export PP_ROLE=hera
export FACTER_IS_BOOTSTRAP=true
bash /opt/puppet_control/bin/bootstrap.sh

echo 'Done'
sudo poweroff
