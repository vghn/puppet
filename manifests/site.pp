# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run.

# Define filebucket 'main'
filebucket { 'main': server => $servername, path   => false }

# Make filebucket 'main' the default backup location for all File resources
File { backup => 'main' }

# Exec defaults:
Exec { path => '/usr/local/bin:/usr/bin:/usr/sbin/:/bin:/sbin' }

# DEFAULT NODE
node default {
  if $::role {
    include "role::${::role}"
  } else {
    warning('The \'role\' fact could not be found! Applying defaults')
    include 'role::none'
  }
}
