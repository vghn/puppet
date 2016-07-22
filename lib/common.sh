#!/usr/bin/env bash
# Common tasks

# Archive artifact
archive_artifact(){
  artifact="vpm_${VERSION}-${GIT_SHA1}.tgz"
  artifact_path="${TMPDIR}/${artifact}"

  # Only pack the required files
  e_info 'Creating artifact'
  if ! tar czf "$artifact_path" \
    bin dist/{profile,role}/manifests hieradata lib manifests \
    docker-compose.yml environment.conf envrc hiera.yaml Puppetfile r10k.yaml \
    CHANGELOG.md LICENSE README.md VERSION;
  then
    e_abort "Could not create ${artifact_path}"
  fi
}

# Upload artifact to S3
upload_artifact(){
  e_info 'Uploading artifact'
  if ! aws s3 cp "$artifact_path" "${S3_ARTIFACTS}/${ENVTYPE}/" --quiet; then
    e_abort "Could not upload ${artifact_path} to ${S3_ARTIFACTS}/${ENVTYPE}"
  fi
}

# Create latest artifact (only from production branch)
latest_artifact(){
  if [[ "$ENVTYPE" == 'production' ]]; then
    e_info 'Mark latest'
    if ! aws s3 cp "${S3_ARTIFACTS}/${ENVTYPE}/${artifact}" "${S3_ARTIFACTS}/vpm.tgz" --quiet; then
      e_abort "Could not upload ${S3_ARTIFACTS}/${ENVTYPE}/${artifact} to ${S3_ARTIFACTS}/vpm.tgz"
    fi
  fi
}

# Clean-up
clean_artifact(){
  e_info 'Clean-up artifact'
  rm "$artifact_path" || true
}

# Create artifact
create_artifact(){
  archive_artifact && upload_artifact && latest_artifact
  clean_artifact
}

# Archive Puppet Control Repo
create_archive(){
  backup_dir="${1:?Must specify the directory to archive as the 1st argument}"
  tmp_archive="${TMPDIR}/${NOW}.tgz"

  # Only pack the required files
  e_info "Creating archive (${backup_dir})"
  if ! tar czf "$tmp_archive" -C "$backup_dir" .;
  then
    e_abort "Could not create ${tmp_archive}"
  fi
}

# Upload archive to S3
upload_archive(){
  s3_path="${1:?Must specify the S3 path as the 1st argument}"
  e_info "Uploading archive (${s3_path})"
  if ! aws s3 cp "$tmp_archive" "$s3_path" --quiet; then
    e_abort "Could not upload ${tmp_archive} to ${s3_path}"
  fi
}

# Clean-up
clean_archive(){
  e_info "Clean-up archive ${tmp_archive}"
  rm "$tmp_archive" || true
}

# Backup directory
backup_directory(){
  src="${1:?Must specify the directory to archive as the 1st argument}"
  dst="${2:?Must specify S3 path as the 2nd argument}"

  create_archive "$src"
  upload_archive "$dst"
  clean_archive
}

# Upload private data
sync_up_private_data(){
  e_info "Upload private data (${S3_PRIVATE_DATA})"
  aws s3 sync --delete \
    "$PRIVATE_DATA_REPO" "$S3_PRIVATE_DATA"
}

# Download private data
sync_down_private_data(){
  e_info "Download private data (${S3_PRIVATE_DATA_ALL})"
  aws s3 sync --delete \
    "$S3_PRIVATE_DATA_ALL" "$PRIVATE_DATA"
}

# Upload Hiera Data
sync_up_hieradata(){
  e_info "Upload hiera data (${S3_HIERADATA})"
  aws s3 sync --delete \
    "$HIERA_DATA_REPO" "$S3_HIERADATA"
}

# Download Hiera Data
sync_down_hieradata(){
  e_info "Download hiera data (${S3_HIERADATA_ALL})"
  aws s3 sync --delete \
    "$S3_HIERADATA_ALL" "$HIERA_DATA"
}

# Update control repo
update_repo(){
  git fetch --all && git reset --hard origin/production
}

# Update docker images
docker_compose_update_images(){
  docker-compose build
  docker-compose pull
}

# Start docker compose
docker_compose_start(){
  docker-compose up -d
}

# Start only the specified containers
docker_compose_start_only(){
  docker-compose pull "$@"
  docker-compose up -d --no-deps "$@"
}

# EC2 Run Command
aws_ec2_send_run_command(){
  local role comm desc
  role="$1"
  desc="$2"
  comm="$3"

  e_info "Looking for instances tagged ${role}"
  ids=$(aws ec2 describe-instances \
    --filter Name=tag:Role,Values="$role" Name=instance-state-name,Values=running \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text)
  if [[ -n "$ids" ]]; then
    e_info "Found ids: ${ids}, for group ${role}"
  else
    e_warn 'Did not find any instances!'; return
  fi

  e_info "Sending ec2 run command"
  # shellcheck disable=2086
  command_id=$(aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --instance-ids $ids \
    --parameters commands="$comm" \
    --comment "$desc" \
    --timeout-seconds 600 \
    --query 'Command.CommandId' \
    --output text)

  if [[ -n "$command_id" ]]; then
    e_info "Wait for command (id: $command_id)"
    status=
    until [[ "$status" =~ ^(Success|Failed|Timed Out|Cancelled)$ ]]; do
      status="$(aws ssm list-commands --command-id "$command_id" --query 'Commands[].Status' --output text)"
      sleep 1
    done
    e_info "Command returned '${status}'"
  else
    e_abort 'Could not send command'
  fi
}
