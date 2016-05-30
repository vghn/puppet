#!/usr/bin/env bash
# Common tasks

# Download private data
sync_hieradata(){
  e_info "Sync hiera data (${PP_HIERADATA_S3})"
  aws s3 sync --delete \
    "${APPDIR}/hieradata" "$PP_HIERADATA_S3"
}

# Archive Puppet Control Repo
archive_hieradata(){
  hieradata_archive_path="${TMPDIR}/hieradata.tgz"

  # Only pack the required files
  e_info "Creating hieradata archive (${hieradata_archive_path})"
  if ! tar czf "$hieradata_archive_path" -C "${APPDIR}/hieradata" .;
  then
    e_abort "Could not create ${hieradata_archive_path}"
  fi
}

# Upload archive to S3
archive_upload(){
  e_info "Uploading hieradata archive (${PP_HIERADATA_ARCHIVE_S3PATH})"
  if ! aws s3 cp "$hieradata_archive_path" "$PP_HIERADATA_ARCHIVE_S3PATH" --quiet; then
    e_abort "Could not upload ${hieradata_archive_path} to ${PP_HIERADATA_ARCHIVE_S3PATH}"
  fi
}

# Clean-up
archive_clean(){
  e_info "Cleaning-up hieradata archive ${hieradata_archive_path}"
  rm "$hieradata_archive_path" || true
}

# Upload app
upload_hieradata(){
  sync_hieradata
  archive_hieradata
  archive_upload
  archive_clean
}
