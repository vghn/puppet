FROM vladgh/puppetserver:v0.0.1
MAINTAINER Vlad Ghinea vlad@ghn.me

RUN gem install aws-sdk --no-ri --no-rdoc

COPY csr-sign /usr/local/bin/

# Configure entrypoint
COPY run.sh /
ENTRYPOINT ["/run.sh"]
