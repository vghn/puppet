# Role
if $::trusted['authenticated'] == 'remote' {
  $real_role = $::trusted['extensions']['pp_role']
} elsif $::trusted['authenticated'] == 'local' {
  if defined('$::role') {
    $real_role = $::role
  } else {
    warning('The \'role\' fact was not found!')
    $real_role = undef
  }
} else {
  warning('Unauthorized node!')
}

# File defaults:
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

# Exec defaults:
Exec {
  path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}

# DEFAULT NODE
node default {
  # Classification option 1 - Classes defined in Hiera
  include(lookup('classes', {'merge' => 'unique', 'default_value' => []}))

  # Classification option 2 - Classic roles and profiles classes
  if $real_role {
    info("Applying catalog for role ${real_role}")
    include "::role::${real_role}"
  }
}
