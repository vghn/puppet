#!/usr/bin/env bash
# Common tasks

log(){
  echo "[$(date "+%Y-%m-%dT%H:%M:%S%z") - $(hostname)] ${*}"
}

set_bundle_directory(){
  cd "${1:-}" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
}

upload_private_data(){
  e_info 'Upload .env'
  if ! aws s3 cp "${APPDIR}/.env" "${ENV_S3PATH}/.${ENVTYPE}" --quiet; then
    e_abort "Could not upload ${APPDIR}/.env to ${ENV_S3PATH}/.${ENVTYPE}"
  fi
  e_info 'Upload vault'
  if ! aws s3 sync "${APPDIR}/vault/" "${VAULT_S3PATH}/${ENVTYPE}/" --delete; then
    e_abort "Could not upload ${APPDIR}/vault/ to ${VAULT_S3PATH}/${ENVTYPE}/"
  fi
  e_info 'Upload hieradata'
  if ! aws s3 sync "${APPDIR}/hieradata/" "${HIERA_S3PATH}/${ENVTYPE}/" --delete; then
    e_abort "Could not upload ${APPDIR}/hieradata/ to ${HIERA_S3PATH}/${ENVTYPE}/"
  fi
}

download_private_data(){
  e_info 'Download .env'
  if ! aws s3 cp "${ENV_S3PATH}/.${ENVTYPE}" "${APPDIR}/.env" --quiet; then
    e_abort "Could not download ${ENV_S3PATH}/.${ENVTYPE} to ${APPDIR}/.env"
  fi
  e_info 'Download vault'
  if ! aws s3 sync "${VAULT_S3PATH}/${ENVTYPE}/" "${APPDIR}/vault/" --delete; then
    e_abort "Could not download ${VAULT_S3PATH}/${ENVTYPE}/ to ${APPDIR}/vault/"
  fi
  e_info 'Download hieradata'
  if ! aws s3 sync "${HIERA_S3PATH}/${ENVTYPE}/" "${APPDIR}/hieradata/" --delete; then
    e_abort "Could not download ${HIERA_S3PATH}/${ENVTYPE}/ to ${APPDIR}/hieradata/"
  fi
}

publish_artifact(){
  local archive="vpm_${ENVTYPE}_${VERSION}-${GIT_SHA1}.tgz"
  local archive_latest="vpm_${ENVTYPE}.tgz"
  local archive_path="${TMPDIR}/${archive}"

  e_info 'Pack artifact'
  if ! tar zcvf "$archive_path" \
    .env hieradata vault\
    bin dist/{profile,role}/manifests lib manifests \
    docker-compose.yml environment.conf envrc Puppetfile \
    CHANGELOG.md LICENSE README.md VERSION;
  then
    e_abort "Could not create ${archive_path}"
  fi

  e_info 'Upload artifact'
  if ! aws s3 cp "$archive_path" "${ARTIFACTS_S3PATH}/${archive}"; then
    e_abort "Could not upload ${archive_path} to ${ARTIFACTS_S3PATH}/${archive}"
  fi

  e_info 'Mark latest version'
  if ! aws s3 cp "${ARTIFACTS_S3PATH}/${archive}" "${ARTIFACTS_S3PATH}/${archive_latest}"; then
    e_abort "Could not upload ${ARTIFACTS_S3PATH}/${archive} to ${ARTIFACTS_S3PATH}/${archive_latest}"
  fi
}
