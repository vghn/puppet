FROM vladgh/puppetserver:stable
MAINTAINER Vlad Ghinea vlad@ghn.me

# Environment
ENV AWS_SDK_VERSION='2.5.1'
ENV AWS_DEFAULT_REGION='us-east-1'

# Install packages
RUN gem install aws-sdk --version "$AWS_SDK_VERSION" --no-ri --no-rdoc

# Copy config files
COPY csr-sign /usr/local/bin/
COPY hiera.yaml /etc/puppetlabs/puppet/hiera.yaml

# Health
HEALTHCHECK --interval=30s --timeout=30s --retries=20 CMD \
  curl \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  -H 'Accept: pson' \
  https://$(puppet config print server):8140/production/status/no_key
