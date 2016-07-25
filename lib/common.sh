#!/usr/bin/env bash
# Common tasks

upload_private_data(){
  local archive="${TMPDIR}/private-${ENVTYPE}.tgz"

  e_info 'Pack private data'
  if ! tar zcvf "$archive" .env .private hieradata; then
    e_abort "Could not create ${archive}"
  fi

  e_info 'Upload private data'
  if ! aws s3 cp "$archive" "$S3_PRIVATE"; then
    e_abort "Could not upload ${archive} to ${S3_PRIVATE}"
  fi

  e_info 'Clean-up'
  rm "$archive" || true

  e_ok 'Done'
}

download_private_data(){
  local archive="${TMPDIR}/private-${ENVTYPE}.tgz"

  e_info 'Download private data'
  if ! aws s3 cp "$S3_PRIVATE" "$archive"; then
    e_abort "Could not download ${archive} to ${S3_PRIVATE}"
  fi

  e_info 'Extract private data'
  if ! tar zxvf "$archive" --directory "$APPDIR"; then
    e_abort "Could not extract ${archive}"
  fi

  e_info 'Clean-up'
  rm "$archive" || true

  e_ok 'Done'
}

upload_artifact(){
  local archive="${TMPDIR}/private-${ENVTYPE}.tgz"

  e_info 'Pack artifact'
  if ! tar zcvf "$archive" \
    .env .private hieradata \
    bin dist/{profile,role}/manifests lib manifests \
    docker-compose.yml environment.conf envrc hiera.yaml Puppetfile r10k.yaml \
    CHANGELOG.md LICENSE README.md VERSION;
  then
    e_abort "Could not create ${archive}"
  fi

  e_info 'Upload artifact'
  if ! aws s3 cp "$archive" "$S3_ARTIFACT"; then
    e_abort "Could not upload ${archive} to ${S3_ARTIFACT}"
  fi

  e_info 'Clean-up'
  rm "$archive" || true

  e_ok 'Done'
}

# Update repository
update_repository(){
  local archive="${TMPDIR}/${ENVTYPE}.tgz"
  local archive_tmpdir="${TMPDIR}/${ENVTYPE}"

  e_info 'Download artifact'
  if ! aws s3 cp "$S3_ARTIFACT" "$archive"; then
    e_abort "Could not download ${S3_ARTIFACT} to ${archive}"
  fi

  e_info 'Extract artifact'
  if ! tar zxvf "$archive" -C "$archive_tmpdir"; then
    e_abort "Could not extract ${archive} to ${archive_tmpdir}"
  fi

  e_info 'Update VPM files'
  rsync -avzh --delete "${archive_tmpdir}/" "${APPDIR}/"

  e_ok 'Done'
}
