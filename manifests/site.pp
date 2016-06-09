# Role
if $::trusted['authenticated'] == 'remote' {
  $real_role = $::trusted['extensions']['pp_role']
} elsif $::trusted['authenticated'] == 'local' {
  if $::role {
    $real_role = $::role
  } else {
    warning('The \'role\' fact was not found!')
    $real_role = undef
  }
} else {
  warning('Unauthorized node!')
}

# Exec defaults:
Exec {path => '/usr/local/bin:/usr/bin:/usr/sbin/:/bin:/sbin'}

# DEFAULT NODE
node default {
  if $real_role {
    include "::role::${real_role}"
  } else {
    warning('No valid role found!')
  }
}
