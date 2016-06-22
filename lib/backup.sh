#!/usr/bin/env bash
# Backup tasks

# Archive Puppet Control Repo
create_archive(){
  backup_dir="${1:?Must specify the directory to archive as the 1st argument}"
  tmp_archive="${TMPDIR}/${ENVTYPE}.tgz"

  # Only pack the required files
  e_info "Creating hieradata archive (${tmp_archive})"
  if ! tar czf "$tmp_archive" -C "$backup_dir" .;
  then
    e_abort "Could not create ${tmp_archive}"
  fi
}

# Upload archive to S3
upload_archive(){
  s3_path="${1:?Must specify the S3 path as the 1st argument}"
  e_info "Uploading hieradata archive (${s3_path})"
  if ! aws s3 cp "$tmp_archive" "$s3_path" --quiet; then
    e_abort "Could not upload ${tmp_archive} to ${s3_path}"
  fi
}

# Clean-up
clean_archive(){
  e_info "Cleaning-up hieradata archive ${tmp_archive}"
  rm "$tmp_archive" || true
}
