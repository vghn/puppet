# Puppet Control Repo
  [![Build Status](https://travis-ci.org/vghn/puppet.svg?branch=master)](https://travis-ci.org/vghn/puppet)

## Development status ##
This project is still in a prototype development stage.

## Overview
Vlad's Puppet Control Repo.

## Description
### bin/
Contains various executable scripts.

### dist/
Contains organization-specific roles and profiles.
This directory is specified as a modulepath in environment.conf
[Designing Puppet – Roles and Profiles.](http://www.craigdunn.org/2012/05/239/)

### docker/
Contains various Dockerfiles for the Docker images.

### hieradata/
Contains the hiera data files. It's intended to serve as a base only, for
public data, with sane defaults. It should be overwritten or amended with data
from private sources.

### lib/
Contains various functions that can be sourced in other scripts (ruby & bash).

### manifests/
Contains Puppet's manifests:
  - `site.pp`: the main manifest

### spec/
Contains test definitions.

### tasks/
Contains rake tasks.

### vault/
Contains private data.

### .env
Contains private environment variables.

### docker-compose.yml
This file defines services, networks and volumes for the containers.
Additional environments should be suffixed to the name (Ex: docker-compose.dev.yml)

### environment.conf
This file can override several settings whenever the Puppet master is serving
nodes assigned to that environment.
[Config Files: environment.conf](https://docs.puppetlabs.com/puppet/latest/reference/config_file_environment.html)

### envrc
This file contains global variables.
**All variables declared here are public**

### Puppetfile
r10k needs this file to figure out what component modules you want from the
Forge. The result is a modules directory containing all the modules specified in
this file, for each environment/branch. The modules directory is listed in
environment.conf's modulepath.

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

### Docker
Start Puppet Server (without dependencies like sync or log agents)
```
docker-compose up -d server
docker-compose logs -f
```

Generate a CSR attributes file
```
echo -e "extension_requests:\n  pp_role: none" > /tmp/csr_attributes.yaml
```

Run Puppet Agent
```
docker run --rm -it --link puppet_server_1:puppet --net puppet_default -v /tmp/csr_attributes.yaml:/etc/puppetlabs/puppet/csr_attributes.yaml vladgh/puppet agent --test
```

### Unit testing
```
cd dist/profile
bundle exec rake test
```

#### Acceptance testing

```
cd dist/profile
```

Run default set for the first time (default creates all nodes)
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no bundle exec rake integration
```

Subsequent runs
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no BEAKER_provision=no bundle exec rake integration
```

Last run (will destroy the machines)
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_provision=no bundle exec rake integration
```

Complete example:
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no BEAKER_provision=yes BEAKER_debug=yes BEAKER_set=default bundle exec rake integration
```

Other commands:
* List nodes: `bundle exec rake beaker_nodes`

The following environment variables can be used to influence how beaker works:

* `BEAKER_set`: choose a nodeset from `spec/acceptance/nodesets/*.yml`
                defaults to `default`
* `BEAKER_setfile`: specify a nodeset using a full path
* `BEAKER_provision`: set to `no` to re-use existing VMs
* `BEAKER_keyfile`: specify alternate SSH key
* `BEAKER_debug`: set to any value to enable beaker debug logging
* `BEAKER_color`: set to `no` to disable color output
* `BEAKER_destroy`: set to `no` to keep the VMs after the test run. Set to
                    `onpass` to keep the VMs around only after a test failure.
* `ORDERING`: How unrelated resources should be ordered when applying a
              catalog (https://docs.puppetlabs.com/puppet/latest/reference/configuration.html#ordering)
* `PUPPET_INSTALL_TYPE`: specify puppet type (one of: pe, foss, agent)
* `PUPPET_INSTALL_VERSION`: specify the version to install

### Clean-up
```
cd dist/profile
bundle exec rake test_clean
```

## Contribute

1. Open an issue to discuss proposed changes
2. Fork the repository
3. Create your feature branch: `git checkout -b my-new-feature`
4. Commit your changes: `git commit -am 'Add some feature'`
5. Push to the branch: `git push origin my-new-feature`
6. Submit a pull request :D

## License
Licensed under the Apache License, Version 2.0.
