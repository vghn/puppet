#!/usr/bin/env bash
# Common tasks

# Load VGS Library (install if needed)
ensure_vgs(){
  if ! command -v curl >/dev/null 2>&1; then
    echo 'Installing curl'
    apt-get -qy install curl < /dev/null
  fi

  echo 'Install/Update VGS Library'
  local installdir
  if [[ $EUID == 0 ]]; then installdir=/opt/vgs; else installdir=~/vgs; fi

  echo '- Remove any existing installations'
  if [[ -d "$installdir" ]]; then rm -fr "$installdir"; fi
  mkdir -p "$installdir"

  echo '- Downloading VGS library'
  curl -sSL https://s3.amazonaws.com/vghn/vgs.tgz | tar xz -C "$installdir"

  echo '- Load VGS Library'
  # shellcheck disable=1090
  . "${installdir}/load"
}

# Download private data
download_hieradata(){
  e_info 'Sync hiera data'
  aws s3 sync --delete "${HIERADATA_S3}/${ENVTYPE}" "${APPDIR}/hieradata"
}

# Download private data
upload_hieradata(){
  e_info 'Sync hiera data'
  aws s3 sync --delete "${APPDIR}/hieradata" "${HIERADATA_S3}/${ENVTYPE}"
}
