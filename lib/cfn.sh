#!/usr/bin/env bash
# AWS CloudFormation tasks

# Creates a new stack
create_stack(){
  local args="${*:?}"
  e_info 'Creating stack'
  eval "aws cloudformation create-stack ${args}"
}

# Update an existing stack
update_stack(){
  local args="${*:?}"
  e_info 'Updating stack'
  eval "aws cloudformation update-stack ${args}"
}

# Deletes an existing stack
delete_stack(){
  local name="${1:?}"
  e_warn "Deleting stack ${name}"
  eval "aws cloudformation delete-stack --stack-name ${name}"
}

# Validate stack
validate_stack(){
  local body="${1:?}"
  e_info "Validating ${body}"
  aws cloudformation validate-template \
    --output table \
    --template-body "file://${body}"
}

# Validate all stacks
validate_stacks(){
  local stacks_path="${1:?}"
  for stack in ${stacks_path}/*.json; do
    validate_stack "$stack"
  done
}

# Wait for stack to finish
wait_for_stack(){
  local name="${1:?}"
  if ! vgs_aws_cfn_wait "$name"; then
    e_abort "FATAL: The stack ${name} failed"
  fi
}

# Upload CloudFormation templates to S3
upload_cfn_templates(){
  local src="${1:?}/"
  local dst="${2:?}/"
  if aws s3 sync "$src" "$dst" --delete; then
    e_info "Synced ${src} to ${dst}"
  else
    e_abort "Could not sync ${src} to ${dst}"
  fi
}

# Returns the usage instructions
usage(){
  echo "USAGE: ${BASH_SOURCE[0]} [COMMAND] [STACK]" >&2
  echo "COMMANDS: create | update | delete | validate | upload" >&2
  echo "STACKS: vgh" >&2
  return 1
}

# Returns usage instructions if the stack name is not present
check_stack_name(){
  [[ -n "$CFN_STACK_ALIAS" ]] || usage
}

# Returns the desired capacity for the specified AutoScaling Group
get_asg_desired_capacity(){
  local asg count
  asg="$(vgs_aws_cfn_get_output VGH ZeusASGName)"
  count="$(aws autoscaling describe-auto-scaling-groups \
    --auto-scaling-group-names "$asg" \
    --query "AutoScalingGroups[0].DesiredCapacity" \
    --output text || true)"
  [[ "$count" =~ ^[0-9]+$ ]] && echo "$count" || echo 0
}

# Returns the desired running count for the specified ECS Service
get_ecs_service_desired_running_count(){
  local cluster service count
  cluster="$(vgs_aws_cfn_get_output VGH ECSCluster)"
  service="$(vgs_aws_cfn_get_output VGH ECSService)"
  count="$(aws ecs describe-services \
    --cluster "$cluster" \
    --services "$service" \
    --query "services[0].runningCount" \
    --output text || true)"
  [[ "$count" =~ ^[0-9]+$ ]] && echo "$count" || echo 0
}
