# Puppet Control Repo
  [![Build Status](https://travis-ci.org/vghn/puppet.svg?branch=master)](https://travis-ci.org/vghn/puppet)

## Development status ##
This project is still in a prototype development stage.

## Overview
Vlad's Puppet Control Repo.

## Description
### bin/
Contains various executable scripts.

### data/
Contains the hiera data files. It's intended to serve as a base only, for
public data, with sane defaults. It should be overwritten or amended with data
from private sources.

### dist/
Contains organization-specific roles and profiles.
This directory is specified as a modulepath in environment.conf
[Designing Puppet – Roles and Profiles.](http://www.craigdunn.org/2012/05/239/)

### manifests/
Contains Puppet's manifests:
  - `site.pp`: the main manifest

### spec/
Contains test definitions.

### .env
Contains private environment variables.

### environment.conf
This file can override several settings whenever the Puppet master is serving
nodes assigned to that environment.
[Config Files: environment.conf](https://docs.puppetlabs.com/puppet/latest/reference/config_file_environment.html)

### envrc
This file contains global variables.
**All variables declared here are public**

### hiera.yaml
This file configures Hiera per environment

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

### Unit testing
```
cd dist/profile
bundle exec rake test
```

#### Acceptance testing
Run default set for the first time (default is just the base profile):
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no bundle exec rake integration
```

Subsequent runs:
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no BEAKER_provision=no bundle exec rake integration
```

Last run (will destroy the machines):
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_provision=no bundle exec rake integration
```

Complete example:
```
PUPPET_INSTALL_TYPE=agent ORDERING=manifest BEAKER_destroy=no BEAKER_provision=yes BEAKER_debug=yes BEAKER_set=default BEAKER_role=none bundle exec rake integration
```

Other commands:
* List nodes: `bundle exec rake beaker_nodes`

The following environment variables can be used to influence how beaker works:
* `BEAKER_role`: choose a role from `spec/acceptance/support/roles/*.yml`
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
Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
1. Open an issue to discuss proposed changes
2. Fork the repository
3. Create your feature branch: `git checkout -b my-new-feature`
4. Commit your changes: `git commit -am 'Add some feature'`
5. Push to the branch: `git push origin my-new-feature`
6. Submit a pull request :D

## License
Licensed under the Apache License, Version 2.0.
