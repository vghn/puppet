FROM ruby:alpine
MAINTAINER Vlad Ghinea vlad@ghn.me

# Install packages
RUN apk --no-cache add openssl bash git python py-pip groff && \
    pip install awscli

# Set working directory
WORKDIR /app

# Install gems
COPY app/Gemfile /app/Gemfile
RUN apk --no-cache add --virtual build-dependencies ruby-dev build-base && \
    bundle install && \
    apk del build-dependencies

# Environment
ENV RACK_PORT=8523 \
    RACK_ENV=production \
    AWS_DEFAULT_REGION=us-east-1

EXPOSE $RACK_PORT

# Copy application
COPY app /app

# Copy config files
COPY r10k.yaml /etc/puppetlabs/r10k/r10k.yaml

# Configure entrypoint
COPY run.sh /
ENTRYPOINT ["/run.sh"]
