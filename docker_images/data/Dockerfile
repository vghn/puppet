FROM ruby:alpine
MAINTAINER Vlad Ghinea vlad@ghn.me

# Environment
ENV R10K_VERSION='2.3.0'
ENV AWS_VERSION='1.10.49'
ENV AWS_DEFAULT_REGION=us-east-1

# Install packages
RUN apk --no-cache add bash git inotify-tools python && \
    apk --no-cache add --virtual build-dependencies py-pip && \
    pip install awscli=="$AWS_VERSION" && \
    apk del build-dependencies
RUN gem install r10k --version "$R10K_VERSION" --no-ri --no-rdoc

# Copy config files
COPY hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
COPY r10k.yaml /etc/puppetlabs/r10k/r10k.yaml

# Configure entrypoint
COPY run.sh /
ENTRYPOINT ["/run.sh"]
