# Role
if $::trusted['authenticated'] == 'remote' {
  $real_role = $::trusted['extensions']['pp_role']
} elsif $::trusted['authenticated'] == 'local' {
  $real_role = $::role
} else {
  fail('Unauthorized node!')
}

# Exec defaults:
Exec {path => '/usr/local/bin:/usr/bin:/usr/sbin/:/bin:/sbin'}

# DEFAULT NODE
node default {
  if !empty( $::real_role ) {
    include "::role::${::real_role}"
  } else {
    fail('No valid role found!')
  }
}
