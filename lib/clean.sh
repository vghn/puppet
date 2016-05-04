#!/usr/bin/env bash
# Clean-up tasks

# List old S3 keys (keep the 5 most recent)
# http://jmespath.org/specification.html#sort-by
# http://jmespath.org/specification.html#reverse
# http://jmespath.org/tutorial.html#slicing
aws_s3_list_old_keys(){
  aws s3api list-objects \
    --bucket "$AWS_ASSETS_BUCKET" \
    --prefix "${AWS_ASSETS_KEY_PREFIX}/app/${PROJECT_NAME}-" \
    --query "reverse(sort_by(Contents, &LastModified))[${KEEP}:].Key" \
    --output text || e_abort 'Could not list S3 objects'
}

# Purge old S3 keys
aws_s3_purge_deployments(){
  for key in $(aws_s3_list_old_keys); do
    aws s3api delete-object \
      --bucket "$AWS_ASSETS_BUCKET" \
      --key "$key"
    e_info "$key deleted"
  done
}
