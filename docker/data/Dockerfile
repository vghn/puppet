FROM ruby:alpine
MAINTAINER Vlad Ghinea vlad@ghn.me

# Environment
ENV R10K_VERSION='2.3.0'
ENV AWS_CLI_VERSION='1.10.53'
ENV AWS_DEFAULT_REGION='us-east-1'

# Install packages
RUN gem install r10k --version "$R10K_VERSION" --no-ri --no-rdoc
RUN apk --no-cache add bash git python py-pip groff && \
    pip install awscli=="$AWS_CLI_VERSION"

# Copy config files
COPY r10k.yaml /etc/puppetlabs/r10k/r10k.yaml

# Configure entrypoint
COPY run.sh /
ENTRYPOINT ["/run.sh"]
