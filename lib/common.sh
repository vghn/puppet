#!/usr/bin/env bash
# Common tasks

log(){
  echo "[$(date "+%Y-%m-%dT%H:%M:%S%z") - $(hostname)] ${*}"
}

upload_private_data(){
  e_info 'Upload .env'
  if ! aws s3 cp "${APPDIR}/.env" "${ENV_S3PATH}/.${ENVTYPE}" --quiet; then
    e_abort "Could not upload ${APPDIR}/.env to ${ENV_S3PATH}/.${ENVTYPE}"
  fi
  e_info 'Upload vault'
  if ! aws s3 sync "${APPDIR}/vault/" "${VAULT_S3PATH}/${ENVTYPE}/" --delete --exact-timestamps; then
    e_abort "Could not upload ${APPDIR}/vault/ to ${VAULT_S3PATH}/${ENVTYPE}/"
  fi
  e_info 'Upload hieradata'
  if ! aws s3 sync "${APPDIR}/hieradata/" "${HIERA_S3PATH}/${ENVTYPE}/" --delete --exact-timestamps; then
    e_abort "Could not upload ${APPDIR}/hieradata/ to ${HIERA_S3PATH}/${ENVTYPE}/"
  fi
}

download_private_data(){
  e_info 'Download .env'
  if ! aws s3 cp "${ENV_S3PATH}/.${ENVTYPE}" "${APPDIR}/.env" --quiet; then
    e_abort "Could not download ${ENV_S3PATH}/.${ENVTYPE} to ${APPDIR}/.env"
  fi
  e_info 'Download vault'
  if ! aws s3 sync "${VAULT_S3PATH}/${ENVTYPE}/" "${APPDIR}/vault/" --delete --exact-timestamps; then
    e_abort "Could not download ${VAULT_S3PATH}/${ENVTYPE}/ to ${APPDIR}/vault/"
  fi
  e_info 'Download hieradata'
  if ! aws s3 sync "${HIERA_S3PATH}/${ENVTYPE}/" "${APPDIR}/hieradata/" --delete --exact-timestamps; then
    e_abort "Could not download ${HIERA_S3PATH}/${ENVTYPE}/ to ${APPDIR}/hieradata/"
  fi
}
