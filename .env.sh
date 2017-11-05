#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# DEBUG
[ -z "${DEBUG:-}" ] || set -x

# VARs
export APPDIR TMPDIR NOW
APPDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
TMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')
NOW="$(date +"%Y%m%d_%H%M%S")"

# Load private environment
# shellcheck disable=1090
. "${APPDIR}/.env" 2>/dev/null || true

# Load VGS library (https://github.com/vghn/vgs)
# shellcheck disable=1090
. ~/vgs/load || echo 'VGS library is required' 1>&2

# Detect environment
detect_environment 2>/dev/null || true
detect_ci_environment 2>/dev/null || true
ENVTYPE="${ENVTYPE:-production}"
