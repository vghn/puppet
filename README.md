# Puppet Control Repo
  [![Build Status](https://travis-ci.org/vladgh/puppet.svg?branch=master)](https://travis-ci.org/vladgh/puppet)

## Development status ##
This project is still in a prototype development stage.

## Overview
Vlad's Puppet Control Repo.

## Description
### Puppetfile
r10k needs this file to figure out what component modules you want from the
Forge. The result is a modules directory containing all the modules specified in
this file, for each environment/branch. The modules directory is listed in
environment.conf's modulepath.

### environment.conf
This file can override several settings whenever the Puppet master is serving
nodes assigned to that environment.
[Config Files: environment.conf](https://docs.puppetlabs.com/puppet/latest/reference/config_file_environment.html)

### bin/
Contains various executable scripts.

### data/
Contains the hiera data files. It's intended to serve as a base only, for
public data, and it should be overwritten or amended with data from private
sources.

### dist/
Contains organization-specific roles and profiles.
This directory is specified as a modulepath in environment.conf
[Designing Puppet – Roles and Profiles.](http://www.craigdunn.org/2012/05/239/)

### manifests/
Contains Puppet's manifests:
  - `bootstrap.pp`: the bootstrapping manifest
  - `site.pp`: the main manifest

## Testing
### Prerequisites

- Vagrant: https://www.vagrantup.com/
- Docker: https://www.docker.com/
- RVM: https://rvm.io/
- GIT: https://git-scm.com/

```
cd dist/profile
bundle install --path vendor
```

### Unit testing
```
cd dist/profile
bundle exec rake test
```

### Acceptance testing
```
cd dist/profile

# List nodes
bundle exec rake beaker_nodes

# Run node for the first time
bundle exec rake acceptance PUPPET_INSTALL_TYPE=agent BEAKER_destroy=no BEAKER_debug=yes BEAKER_set=ubuntu-trusty-x64

# Subsequent runs
bundle exec rake acceptance PUPPET_INSTALL_TYPE=agent BEAKER_destroy=no BEAKER_provision=no BEAKER_debug=yes  BEAKER_set=ubuntu-trusty-x64

# Last run (will destroy the machines)
bundle exec rake acceptance PUPPET_INSTALL_TYPE=agent BEAKER_provision=no BEAKER_debug=yes BEAKER_set=ubuntu-trusty-x64
```

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
