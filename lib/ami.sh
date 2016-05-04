#!/usr/bin/env bash
# AWS EC2 image tasks

generate_user_data(){
  local file="${TMPDIR}/${FUNCNAME[0]}"
cat <<USERDATA > $file
#!/usr/bin/env bash
set -euo pipefail
IFS=\$'\\n\\t'

# Report status
echo 'IN_PROGRESS' | tee /var/lib/cloud/instance/status_ami

# VARs
export PP_ROLE=zeus
export PP_MASTER=true
export PP_SERVER=puppet.ghn.me
export PP_PROJECT=${PROJECT_NAME}
export ENVTYPE=${ENVTYPE}
export BUILD_DIR="${TMPDIR}/ami_build"
export APP_S3_URL='$(vgs_aws_s3_generate_presigned_url "$AWS_ASSETS_BUCKET" "$APP_ARCHIVE_S3_KEY_LATEST" 300)'
export HOME=/root

echo 'Create project directory'
mkdir -p "\$BUILD_DIR" && cd "\$BUILD_DIR"

echo 'Get AMI build files'
curl -sSL "\$APP_S3_URL" | tar xvz

echo 'Bootstrap Puppet'
bash bin/bootstrap

# Report status
echo 'SUCCEEDED' | tee /var/lib/cloud/instance/status_ami

echo 'Power Off AMI'
poweroff
USERDATA

  echo "$file"
}

create_instance(){
  e_info 'Creating EC2 instance'
  instance_id=$(vgs_aws_ec2_create_instance \
    "$AWS_EC2_KEY" \
    "$AWS_EC2_INSTANCE_TYPE" \
    "$(generate_user_data)")
  e_ok "  ... ${instance_id}"
}

tag_instance(){
  vgs_aws_ec2_create_tags "$instance_id" \
    Key=Group,Value="$AWS_TAG_GROUP" \
    Key=Name,Value="$AWS_EC2_IMAGE_PREFIX"
}

create_image(){
  e_info "Creating image from ${instance_id}"
  image_id=$(vgs_aws_ec2_image_create \
    "$instance_id" \
    "$AWS_EC2_IMAGE_PREFIX" \
    "$AWS_EC2_IMAGE_DESCRIPTION")
  e_ok "  ... ${image_id}"
}

tag_image(){
  vgs_aws_ec2_create_tags "$image_id" \
    Key=Group,Value="$AWS_TAG_GROUP" \
    Key=Name,Value="$AWS_EC2_IMAGE_PREFIX" \
    Key=Version,Value="$VERSION"
}

clean_up(){
  e_info 'Terminating instances'
  aws ec2 terminate-instances \
    --instance-ids "$instance_id" \
    --output text \
    --query 'TerminatingInstances[*].InstanceId'
  e_ok "  ... ${instance_id}"
}

create_ami(){
  package_app_files && upload_app_archive
  create_instance && tag_instance
  e_info 'Waiting for instance to start'
  aws ec2 wait instance-running --instance-ids "$instance_id"
  e_info 'Waiting for instance to bootstrap and power off'
  aws ec2 wait instance-stopped --instance-ids "$instance_id" || \
    ( clean_up; e_abort 'Could not create image')

  create_image && tag_image
  e_info 'Waiting for image to be available'
  aws ec2 wait image-available --image-ids "$image_id"

  clean_up
}
