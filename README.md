# Puppet Control Repo

## Development status ##
This project is still in a prototype development stage.

## Overview
Controls Vlad's environments.

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

### data
Contains the hiera data files. It's intended to serve as a base only, for
public data, and it should be overwritten or ammended with data from private
sources.

### dist/
Contains organization-specific roles and profiles.
This directory is specified as a modulepath in environment.conf
[Designing Puppet – Roles and Profiles.](http://www.craigdunn.org/2012/05/239/)

### hooks/
Contains GIT hooks.

### manifests/
Contains Puppet's main manifests:
  - `site.pp`

### provision/
Contains the scripts and files that are used to spin up the nodes.

## License ##
Licensed under the Apache License, Version 2.0.