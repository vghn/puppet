#!/usr/bin/env bash
# Common AWS functions

# Load environment
# shellcheck disable=1090
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/common.sh"

# AWS Region
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"

# NAME: aws_get_metadata
# DESCRIPTION: AWS MetaData Service
aws_get_metadata(){
  wget --timeout=2 --tries=0 -qO- "http://169.254.169.254/latest/meta-data/${*}"
}

# NAME: aws_get_instance_id
# DESCRIPTION: Returns the EC2 instance ID for the local instance
aws_get_instance_id() {
  if [ -z "${INSTANCE_ID}" ]; then
    export INSTANCE_ID; INSTANCE_ID=$(aws_get_metadata instance-id || true)
  fi
  echo "$INSTANCE_ID"
}

# NAME: aws_get_instance_az
# DESCRIPTION: Returns the the AWS availability zone
aws_get_instance_az() {
  local az; az=$(aws_get_metadata placement/availability-zone)
  if [[ "$az" =~ ^[a-z]{2}-[a-z]+-[0-9][a-z]$ ]]; then
    echo "$az"
  else
    echo "Invalid availability zone name: '${az}'"; return 1
  fi
}

# NAME: aws_get_instance_region
# DESCRIPTION: Returns the the AWS region
aws_get_instance_region() {
  local zone; zone=$(aws_get_instance_az)
  echo "${zone%?}"
}

# NAME: list_all_tags
# DESCRIPTION: Returns all EC2 tags associated with the current instance
list_all_tags(){
  aws --output text ec2 describe-tags \
    --filters "Name=resource-id,Values=$(aws_get_instance_id)" \
    --query "Tags[*].[join(\`=\`,[Key,Value])]" 2>/dev/null | \
    awk '{print tolower($0)}' | \
    sed 's/.*/ec2_tag_&/'
}

# NAME: aws_get_tag
# DESCRIPTION: Gets the value of an ec2 tag.
# USAGE: aws_get_tag {Key Name} {Resource ID}
# PARAMETERS:
#   1) The key name (defaults to 'Name')
#   2) The resource id (defaults to the current instance id)
aws_get_tag(){
  local name=${1:-'Name'}
  local instance_id; instance_id=$(aws_get_instance_id)
  local resource=${2:-$instance_id}

  aws --output text ec2 describe-tags \
    --filters "Name=resource-id,Values=${resource}" "Name=key,Values=$name" \
    --query "Tags[*].[Value]" 2>/dev/null
}

# NAME: aws_get_instance_state_asg
# DESCRIPTION: Gets the state of the given <EC2 instance ID> as known by the AutoScaling
# group it's a part of.
# USAGE: aws_get_instance_state_asg {EC2 instance ID}
# PARAMETERS:
#   1) The instance id
aws_get_instance_state_asg() {
  local instance_id=$1
  local state; state=$(aws autoscaling describe-auto-scaling-instances \
    --instance-ids "$instance_id" \
    --query "AutoScalingInstances[?InstanceId == \`$instance_id\`].LifecycleState | [0]" \
    --output text)
  if [ $? != 0 ]; then
    return 1
  else
    echo "$state"
    return 0
  fi
}

# NAME: aws_get_autoscaling_group_name
# DESCRIPTION: Returns the name of the AutoScaling group this instance is a
# part of.
# USAGE: aws_get_autoscaling_group_name {EC2 instance ID}
# PARAMETERS:
#   1) The instance id
aws_get_autoscaling_group_name() {
  local instance_id=$1
  local autoscaling_name; autoscaling_name=$(aws autoscaling \
    describe-auto-scaling-instances \
    --instance-ids "$instance_id" \
    --output text \
    --query AutoScalingInstances[0].AutoScalingGroupName)

  if [ $? != 0 ]; then
    return 1
  else
    echo "$autoscaling_name"
  fi

  return 0
}

# NAME: aws_autoscaling_enter_standby
# DESCRIPTION: Move the instance into the Standby state in AutoScaling group
aws_autoscaling_enter_standby(){
  local instance_id; instance_id=$(aws_get_instance_id)
  local asg_name; asg_name=$(aws_get_autoscaling_group_name "$instance_id")

  echo "Checking if this instance has already been moved in the Standby state"
  local instance_state
  instance_state=$(aws_get_instance_state_asg "$instance_id")
  if [ $? != 0 ]; then
    echo "Unable to get this instance's lifecycle state."
    return 1
  fi

  if [ "$instance_state" == "Standby" ]; then
    echo "Instance is already in Standby; nothing to do."
    return 0
  elif [ "$instance_state" == "Pending" ]; then
    echo "Instance is Pending; nothing to do."
    return 0
  elif [ "$instance_state" == "Pending:Wait" ]; then
    echo "Instance is Pending:Wait; nothing to do."
    return 0
  fi

  echo "Putting instance $instance_id into Standby"
  aws autoscaling enter-standby \
    --instance-ids "$instance_id" \
    --auto-scaling-group-name "$asg_name" \
    --should-decrement-desired-capacity
  if [ $? != 0 ]; then
    echo "Failed to put instance $instance_id into Standby for ASG $asg_name."
    return 1
  fi

  printf "Waiting for instance to reach state Standby..."
  while [ "$(aws_get_instance_state_asg "$instance_id")" != "Standby" ]; do
    printf '.' && sleep 5
  done
  echo ' Done.'

  return 0
}

# NAME: aws_autoscaling_exit_standby
# DESCRIPTION: Attempts to move instance out of Standby and into InService.
aws_autoscaling_exit_standby(){
  local instance_id; instance_id=$(aws_get_instance_id)
  local asg_name; asg_name=$(aws_get_autoscaling_group_name "$instance_id")

  echo "Checking if this instance has already been moved out of Standby state"
  local instance_state
  instance_state=$(aws_get_instance_state_asg "$instance_id")
  if [ $? != 0 ]; then
    echo "Unable to get this instance's lifecycle state."
    return 1
  fi

  if [ "$instance_state" == "InService" ]; then
    echo "Instance is already in InService; nothing to do."
    return 0
  elif [ "$instance_state" == "Pending" ]; then
    echo "Instance is Pending; nothing to do."
    return 0
  elif [ "$instance_state" == "Pending:Wait" ]; then
    echo "Instance is Pending:Wait; nothing to do."
    return 0
  fi

  echo "Moving instance $instance_id out of Standby"
  aws autoscaling exit-standby \
    --instance-ids "$instance_id" \
    --auto-scaling-group-name "$asg_name"
  if [ $? != 0 ]; then
    echo "Failed to put instance $instance_id back into InService for ASG $asg_name."
    return 1
  fi

  printf "Waiting for instance to reach state InService..."
  while [ "$(aws_get_instance_state_asg "$instance_id")" != "InService" ]; do
    printf '.' && sleep 5
  done
  echo ' Done.'

  return 0
}

# NAME: aws_deploy_list_running_deployments
# DESCRIPTION: Returns the a list of running deployments for the given
# CodeDeploy application and group.
# USAGE: aws_deploy_list_running_deployments {App} {Group}
# PARAMETERS:
#   1) The application name
#   2) The deployment group name
aws_deploy_list_running_deployments() {
  local app=$1
  local group=$2

  aws deploy list-deployments \
    --output text \
    --query 'deployments' \
    --application-name "$1" \
    --deployment-group-name "$2" \
    --include-only-statuses Queued InProgress
}

# NAME: aws_deploy_group_exists
# DESCRIPTION: Returns true if the given deployment group exists.
# USAGE: aws_deploy_group_exists {App} {Group}
# PARAMETERS:
#   1) The application name
#   2) The deployment group name
aws_deploy_group_exists() {
  local app=$1
  local group=$2

  aws deploy get-deployment-group \
    --query 'deploymentGroupInfo.deploymentGroupId' --output text \
    --application-name "$1" \
    --deployment-group-name "$2" >/dev/null
}

# NAME: aws_deploy_wait
# DESCRIPTION: Waits until there are no other deployments in progress for the
# given CodeDeploy application and group.
# USAGE: aws_deploy_wait {App} {Group}
# PARAMETERS:
#   1) The application name
#   2) The deployment group name
aws_deploy_wait() {
  local app=$1
  local group=$2

  echo 'Waiting for other deployments to finish ...'
  until [[ -z "$(aws_deploy_list_running_deployments "$app" "$group")" ]]; do
    sleep 5
  done
  echo ' Done.'
}

# NAME: aws_deploy_create_deployment
# DESCRIPTION: Creates a CodeDeploy revision.
# USAGE: aws_deploy_create_deployment {App} {Group} {Bucket} {Key} {Bundle} {Config}
# PARAMETERS:
#   1) The application name
#   2) The deployment group name
#   3) The S3 bucket name
#   4) The S3 key name
#   5) The bundle type ("tar"|"tgz"|"zip")
#   6) The deployment config name
aws_deploy_create_deployment(){
  local app=$1
  local group=$2
  local bucket=$3
  local key=$4
  local bundle=$5
  local config=$6

  if aws_deploy_group_exists "$@"; then
    aws_deploy_wait "$@"

    echo "Creating deployment for application '${app}', group '${group}'"
    aws deploy create-deployment \
      --application-name "$app" \
      --s3-location bucket="${bucket}",key="${key}",bundleType="${bundle}" \
      --deployment-group-name "$group" \
      --deployment-config-name "$config"
  else
    echo "The '${group}' group does not exist in the '${app}' application"
  fi
}

# NAME: aws_get_private_env
# DESCRIPTION: Retrieves a private file from AWS S3, saves it to a .env file
# in the current directory, and applies strict read-only permissions. The file
# is sourced afterwards. This function fails silently, and returns 0.
# USAGE: aws_get_private_env {S3 Path}
# PARAMETERS:
#   1) The S3 path to the file (required)
aws_get_private_env(){
  local src=$1
  local file; file="$(pwd)/.env"
  if [ -z "$src" ]; then
    echo "Usage: ${FUNCNAME[0]} {S3 Path}" && return
  fi
  if [ -s "$file" ]; then
    echo "File '${file}' already exists. Replacing"
    sudo rm "$file"
  fi
  aws s3 cp "$src" "$file" || echo "Failed to get ${src}"
  if [ -s "$file" ]; then
    echo "Setting permissions for ${file}"
    sudo chmod 400 "$file"
    echo "Loading ${file}"
    # shellcheck disable=1090
    . "$file" || echo "Failed to load ${file}"
  else
    echo "'${file}' does not exist" && return
  fi
}

# NAME: aws_get_ubuntu_official_ami_id
# DESCRIPTION: Retrieves the latest AMI ID for the official Ubuntu image.
# The region should be exported separately as part of the awscli instalation
# (Defaults to us-east-1).
# USAGE: aws_get_ubuntu_official_ami_id {Distribution} {Type} {Arch} \
#          {Virtualization}
# PARAMETERS:
#   1) Distribution code name (defaults to 'trusty')
#   2) Root device type (defaults to 'ebs-ssd')
#   3) Architecture (defaults to 'amd64')
#   4) Virtualization (defaults to 'hvm')
aws_get_ubuntu_official_ami_id() {
  local dist=${1:-trusty}
  local dtyp=${2:-ebs-ssd}
  local arch=${3:-amd64}
  local virt=${4:-hvm}
  local region=${AWS_REGION:-us-east-1}

  curl -Ls "http://cloud-images.ubuntu.com/query/${dist}/server/released.current.txt" | \
    awk -v region="$region" \
        -v dist="$dist" \
        -v dtyp="$dtyp" \
        -v arch="$arch" \
        -v virt="$virt" \
    '$5 == dtyp && $6 == arch && $7 == region && $9 == virt { print $8 }'
}

# NAME: aws_cfn_wait_for_stack
# DESCRIPTION: Waits for the CloudFormation stack.
# USAGE: aws_cfn_wait_for_stack {App} {Group}
# PARAMETERS:
#   1) Stack name
aws_cfn_wait_for_stack(){
  local stack="$1"
  local status='UNKNOWN_IN_PROGRESS'

  if [[ -z "$stack" ]]; then echo "Usage: ${FUNCNAME[0]} stack"; return 1; fi

  echo "Waiting for $stack to complete ..." >&2
  until [[ $status =~ _(COMPLETE|FAILED)$ ]]; do
    status="$(aws cloudformation describe-stacks --stack-name "$1" --output text --query 'Stacks[0].StackStatus')" || return 1
    echo " ... $stack - $status" >&2
    sleep 5
  done

  echo "$status"

  # if status is failed or we'd rolled back, assume bad things happened
  if [[ $status =~ _FAILED$ ]] || [[ $status =~ ROLLBACK ]]; then
    return 1
  fi
}

# NAME: aws_cf_tail
# DESCRIPTION: Show all events for CF stack until update completes or fails.
# USAGE: aws_cf_tail {Stack name}
# PARAMETERS:
#   1) Stack name (required)
aws_cf_tail() {
  if [ -z "$1" ] ; then echo "Usage: ${FUNCNAME[0]} stack"; return 1; fi
  local stack
  stack="$(basename "$1" .json)"
  local current
  local final_line
  local output
  local previous
  until echo "$current" | tail -1 | egrep -q "${stack}.*_(COMPLETE|FAILED)"
  do
    if ! output=$(cf_events "$stack"); then
      # Something went wrong with cf_events (like stack not known)
      return 1
    fi
    if [ -z "$output" ]; then sleep 1; continue; fi

    current=$(echo "$output" | sed '$d')
    final_line=$(echo "$output" | tail -1)
    if [ -z "$previous" ]; then
      echo "$current"
    elif [ "$current" != "$previous" ]; then
      comm -13 <(echo "$previous") <(echo "$current")
    fi
    previous="$current"
    sleep 1
  done
  echo "$final_line"
}

# NAME: aws_cf_events
# DESCRIPTION: Show all events for CF stack until update completes or fails.
# USAGE: aws_cf_events {Stack name}
# PARAMETERS:
#   1) Stack name (required)
aws_cf_events() {
  if [ -z "$1" ] ; then echo "Usage: ${FUNCNAME[0]} stack"; return 1; fi
  local stack
  stack="$(basename "$1" .json)"
  shift
  local output
  if output=$(aws --color on cloudformation describe-stack-events --stack-name "$stack" --query 'sort_by(StackEvents, &Timestamp)[].{Resource: LogicalResourceId, Type: ResourceType, Status: ResourceStatus}' --output table "$@"); then
    echo "$output" | uniq -u
  else
    return $?
  fi
}

# NAME: aws_get_elb_name
# DESCRIPTION: Returns the ELB to which the instance is registered.
aws_get_elb_name() {
  local instance_id; instance_id=$(aws_get_instance_id)
  if output=$(aws elb describe-load-balancers --query "LoadBalancerDescriptions[?contains(Instances[].InstanceId, \`${instance_id}\`)].LoadBalancerName" --output text); then
    echo "$output"
  else
    return $?
  fi
}

# NAME: aws_elb_get_health_check
# DESCRIPTION: Returns the Elastic Load Balancer health check configuration
aws_elb_get_health_check() {
  local elb; elb=$(aws_get_elb_name)
  if output=$(aws elb describe-load-balancers --load-balancer-names "$elb" --query 'LoadBalancerDescriptions[].HealthCheck | [0]'); then
    echo "$output"
  else
    return $?
  fi
}

# NAME: aws_elb_configure_health_check
# DESCRIPTION: Modifies the Elastic Load Balancer' health check configuration
# USAGE: aws_elb_configure_health_check {Config}
# PARAMETERS:
#   1) Configuration (required)
#      Ex: Target=HTTP:80/,Interval=10,UnhealthyThreshold=5,HealthyThreshold=2,Timeout=5
aws_elb_configure_health_check() {
  local elb; elb=$(aws_get_elb_name)
  if output=$(aws elb configure-health-check --load-balancer-name "$elb" --health-check "$1"); then
    echo "$output"
  else
    return $?
  fi
}

# NAME: aws_ecs_list_clusters
# DESCRIPTION: Returns a list of EC2 Container Service Clusters
aws_ecs_list_clusters(){
  if output=$(aws ecs list-clusters --query 'clusterArns[]' --output text); then
    echo "$output"
  else
    return $?
  fi
}

# NAME: aws_mount_efs
# DESCRIPTION: Mount AWS Elastic File System
# USAGE: aws_mount_efs {EFS ID} {path}
# PARAMETERS:
#   1) Elastic File System ID (required)
#   2) The local path where to mount the EFS
aws_mount_efs(){
  local id=$1
  local path=$2
  local zone; zone=$(aws_get_instance_az)
  local mnt="${zone}.${id}.efs.${zone%?}.amazonaws.com:/"

  # Check arguments
  if [ $# -eq 0 ] ; then echo "Usage: ${FUNCNAME[0]} EFS_ID PATH"; return 1; fi
  # Check if NFS tools are installed
  if ! is_cmd mount.nfs4; then echo "Install 'nfs-common' first"; return 1; fi
  # Check if already mounted
  if mount | grep -q "$mnt"; then echo "'${mnt}' already mounted"; return; fi

  if [ ! -d "$path" ]; then
    echo "Creating '${path}' and mounting Elastic File System"
    mkdir -p "$path"
  else
    echo "'${path}' already present"
  fi
  echo "Mounting Elastic File System at '${path}'"
  mount -t nfs4 "$mnt" "$path"
}

