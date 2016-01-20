#!/usr/bin/env bash
# Common functions

# Immediately exit on errors
set -euo pipefail

# Load private environment
# shellcheck disable=1090
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/../.env" || true

# Load global environment
# shellcheck disable=1090
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/../environment.sh" || true

# FUNCTIONS
## Check if root
is_root()   { [[ $EUID == 0 ]] ;}

## Check if is Linux
is_linux(){ [[ $(uname) != Linux ]] ;}

## Check if command exists
is_cmd() { command -v "$@" >/dev/null 2>&1 ;}

## Get codename
get_dist() { is_cmd lsb_release && lsb_release -cs ;}

## APT install package
apt_install(){ echo "Installing $*"; apt-get -qy install "$@" < /dev/null ;}

## Update APT
apt_update() { echo 'Updating APT' && apt-get -qy update < /dev/null ;}

## Upgrade box
apt_upgrade(){ echo 'Upgrading box' && sudo apt-get -qy upgrade < /dev/null ;}
