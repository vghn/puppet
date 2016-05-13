#!/usr/bin/env bash
# Common tasks

# Download private data
upload_hieradata(){
  e_info 'Sync hiera data'
  aws s3 sync --delete "${APPDIR}/hieradata" "${HIERADATA_S3}/${ENVTYPE}"
}
