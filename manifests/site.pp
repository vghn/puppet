# Exec defaults:
Exec { path => '/usr/local/bin:/usr/bin:/usr/sbin/:/bin:/sbin' }

# DEFAULT NODE
node default {
  if $::trusted['authenticated'] == 'remote' {
    $real_role = $::trusted['extensions']['pp_role']
  } elsif $::trusted['authenticated'] == 'local' {
    $real_role = $::role
  } else {
    fail('Unauthorized node!')
  }

  if !empty( $real_role ) {
    include "::role::${::role}"
  } else {
    fail('The \'pp_role\' or the \'role\' fact could not be found!')
  }
}
