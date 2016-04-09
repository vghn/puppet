# Puppet Control Repo
  [![Build Status](https://travis-ci.org/vghn/puppet.svg?branch=master)](https://travis-ci.org/vghn/puppet)

## Development status ##
This project is still in a prototype development stage.

## Overview
Vlad's Puppet Control Repo.

## Description
### bin/
Contains various executable scripts.

### cfn/
Contains AWS CloudFormation templates.

### dist/
Contains organization-specific roles and profiles.
This directory is specified as a modulepath in environment.conf
[Designing Puppet – Roles and Profiles.](http://www.craigdunn.org/2012/05/239/)

### hieradata/
Contains the hiera data files. It's intended to serve as a base only, for
public data, with sane defaults. It should be overwritten or amended with data
from private sources.

### include/
Contains various functions that can be sourced in other scripts.

### manifests/
Contains Puppet's manifests:
  - `site.pp`: the main manifest

### Puppetfile
r10k needs this file to figure out what component modules you want from the
Forge. The result is a modules directory containing all the modules specified in
this file, for each environment/branch. The modules directory is listed in
environment.conf's modulepath.

### environment.conf
This file can override several settings whenever the Puppet master is serving
nodes assigned to that environment.
[Config Files: environment.conf](https://docs.puppetlabs.com/puppet/latest/reference/config_file_environment.html)

### defaults.env
This file contains global variables. **All
variables declared here are public**. Any sensitive information should be
placed in an `.env` file which will overwrite the information here.

## Testing
### Prerequisites

- Vagrant: https://www.vagrantup.com/
- Docker: https://www.docker.com/
- RVM: https://rvm.io/
- GIT: https://git-scm.com/

```
cd dist/profile
bundle install
```

### Unit testing
```
cd dist/profile
bundle exec rake test
```

#### Acceptance testing

`cd dist/profile`

List nodes:

`bundle exec rake beaker_nodes`

Run default set for the first time (default creates all nodes)

`PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no bundle exec rake acceptance`

Subsequent runs

`PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no BEAKER_provision=no bundle exec rake acceptance`

Last run (will destroy the machines)

`PUPPET_INSTALL_TYPE=agent BEAKER_provision=no bundle exec rake acceptance`

The following environment variables can be used to influence how beaker works:

* `BEAKER_color`: set to `no` to disable color output
* `BEAKER_set`: choose a nodeset from `spec/acceptance/nodesets/*.yml`
                defaults to `default`
* `BEAKER_setfile`: specify a nodeset using a full path
* `BEAKER_provision`: set to `no` to re-use existing VMs
* `BEAKER_keyfile`: specify alternate SSH key
* `BEAKER_debug`: set to any value to enable beaker debug logging
* `BEAKER_destroy`: set to `no` to keep the VMs after the test run. Set to
                    `onpass` to keep the VMs around only after a test failure.
* ` ORDERING`: How unrelated resources should be ordered when applying a
               catalog (https://docs.puppetlabs.com/puppet/latest/reference/configuration.html#ordering)

### Clean-up
```
cd dist/profile
bundle exec rake test_clean
```

### Infrastructure

* AMI: The script will pack the needed files, upload them to S3, create a temporary pre-signed URL and create an instance. That instance will upgrade itself first, then will install and upgrade Python PIP (use bash for this because Puppet runs pip upgrade every time it runs). It also installs the VGS Library. It downloads and extracts the archive from the pre-signed URL and runs the bootstrap script. The bootstrap script installs the newer Puppet Agent with Puppet 4, configures R10K and Hiera and applies the right manifests. The manifests install ssh keys, essential packages, the latest git from the official repo, CloudWatch Logs, CloudFormation helper scripts, CodeDeploy agent, Simple Systems Manager Agent (for the EC2 run command), RVM with newer Ruby (2.2.1), JQ Json Processor, Docker Engine, Docker Compose, Docker Machine, and AWS the Elastic Container Service Agent. It also updates Hiera and R10K with the latest configuration.

* CloudFormation: First time, the auto scaling groups should be set at 0 at creation so that all other resources are created before the instances. Run `bin/ci deploy` manually to upload the required files. Increase the number of instances in the CloudFormation template and update it. Because they are pre-configured during AMI creation they should only start, and the ELB will determine if AWS ECS Agent is listening on the right port.

* Lambdas: Uploaded during CI deployment and created during CloudFormation create/update commands.

* CI (TravisCI):
  * CI installs Python PIP with awscli, and downloads a `.env` file from a private bucket. It also installs all the gems required for testing the profile puppet module using bundle, and triggers the task that downloads all other puppet modules.
  * CI Test: Validates the CloudFormation templates, and the profile puppet module
  * CI Deploy: Uploads the CloudFormation templates to an S3 bucket, prefixed by the branch name. It also creates a zip with each AWS Lambda function and uploads them to the S3 bucket.

## Contribute

1. Open an issue to discuss proposed changes
2. Fork the repository
3. Create your feature branch: `git checkout -b my-new-feature`
4. Commit your changes: `git commit -am 'Add some feature'`
5. Push to the branch: `git push origin my-new-feature`
6. Submit a pull request :D

## License
Licensed under the Apache License, Version 2.0.
