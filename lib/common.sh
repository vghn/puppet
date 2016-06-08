#!/usr/bin/env bash
# Common tasks

# Wait for data to deployed
wait_for_data(){
  until [[ -s /var/local/data_deployed ]]; do
    >&2 echo "Data did not deploy - sleeping"
    sleep 5
  done
}

# Upload private data
sync_up_private_data(){
  e_info "Upload private data (${PP_PRIVATE_DATA_S3})"
  aws s3 sync --delete \
    "$PRIVATE_DATA_DIR" "$PP_PRIVATE_DATA_S3"
}

# Download private data
sync_down_private_data(){
  e_info "Download private data (${PP_PRIVATE_DATA_S3})"
  aws s3 sync --delete \
    "$PP_PRIVATE_DATA_S3" "$PRIVATE_DATA_DIR"
}

# Upload Hiera Data
sync_up_hieradata(){
  e_info "Upload hiera data (${PP_HIERADATA_S3})"
  aws s3 sync --delete \
    "$HIERA_DATA_DIR" "$PP_HIERADATA_S3"
}

# Download Hiera Data
sync_down_hieradata(){
  e_info "Download hiera data (${PP_HIERADATA_S3})"
  aws s3 sync --delete \
    "$PP_HIERADATA_S3" "$HIERA_DATA_DIR"
}

# Archive Puppet Control Repo
create_archive(){
  archive_path="${TMPDIR}/${ENVTYPE}.tgz"

  # Only pack the required files
  e_info "Creating hieradata archive (${archive_path})"
  if ! tar czf "$archive_path" -C "$APPDIR" .;
  then
    e_abort "Could not create ${archive_path}"
  fi
}

# Upload archive to S3
upload_archive(){
  e_info "Uploading hieradata archive (${ARCHIVE_S3PATH})"
  if ! aws s3 cp "$archive_path" "$ARCHIVE_S3PATH" --quiet; then
    e_abort "Could not upload ${archive_path} to ${ARCHIVE_S3PATH}"
  fi
}

# Clean-up
clean_archive(){
  e_info "Cleaning-up hieradata archive ${archive_path}"
  rm "$archive_path" || true
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
