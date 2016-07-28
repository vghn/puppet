FROM vladgh/puppetserver:v0.0.1
MAINTAINER Vlad Ghinea vlad@ghn.me

# Environment
ENV AWS_SDK_VERSION='2.4.3'
ENV AWS_DEFAULT_REGION='us-east-1'

# Install packages
RUN gem install aws-sdk --version "$AWS_SDK_VERSION" --no-ri --no-rdoc

# Copy config files
COPY csr-sign /usr/local/bin/
COPY hiera.yaml /etc/puppetlabs/puppet/hiera.yaml

# Configure entrypoint
COPY run.sh /
ENTRYPOINT ["/run.sh"]
