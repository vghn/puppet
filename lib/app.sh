#!/usr/bin/env bash
# Application tasks

# Download private data
download_private_data(){
  e_info 'Sync hiera data'
  aws s3 sync --delete "$PP_HIERA_S3_PATH" "${APPDIR}/hieradata"
}

# Download private data
upload_private_data(){
  e_info 'Sync hiera data'
  aws s3 sync --delete "${APPDIR}/hieradata" "$PP_HIERA_S3_PATH"
}

# Archive app files
package_app_files(){
  app_archive_path="${TMPDIR}/${APP_ARCHIVE}"

  # Only pack essential files
  e_info "Creating application archive (${app_archive_path})"
  if ! tar cvzf "$app_archive_path" \
    bin/ dist/profile/{manifests,templates} dist/profile/spec/acceptance/support \
    dist/role/manifests hieradata/ manifests/ spec/ .rspec env.sh \
    environment.conf Gemfile Puppetfile Rakefile \
    LICENSE README.md VERSION;
  then
    e_abort "Could not create ${app_archive_path}"
  fi
}

# Upload archive to S3
upload_app_archive(){
  e_info "Uploading app archive to S3 (${APP_ARCHIVE_S3_PATH})"
  if ! aws s3 cp "$app_archive_path" "$APP_ARCHIVE_S3_PATH"; then
    e_abort "Could not upload ${app_archive_path} to ${APP_ARCHIVE_S3_PATH}"
  fi

  e_info "Creating latest app archive (${APP_ARCHIVE_S3_PATH_LATEST})"
  if ! aws s3 cp "$APP_ARCHIVE_S3_PATH" "$APP_ARCHIVE_S3_PATH_LATEST"; then
    e_abort "Could not create latest app archive (${APP_ARCHIVE_S3_PATH_LATEST})"
  fi
}

# Update app
update_app(){
  download_private_data
}

# Clean-up
clean_app(){
  e_info "Cleaning-up ${app_archive_path}"
  rm "$app_archive_path" || true
}
