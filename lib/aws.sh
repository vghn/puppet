#!/usr/bin/env bash
# AWS tasks

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
