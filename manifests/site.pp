# Main Puppet manifest

# File defaults:
case $facts['kernel'] {
  'Darwin': {
    File {
      owner => 'root',
      group => 'wheel',
      mode  => '0644',
    }
  }
  default: {
    File {
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
  }
}

# Exec defaults:
Exec {
  path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}

# DEFAULT NODE
# Only trusted facts are allowed for authenticated nodes.
# See: https://docs.puppet.com/puppet/latest/lang_facts_and_builtin_vars.html#trusted-facts
node default {
  # Classification option 1 - Classes defined in Hiera
  lookup({
    'name'          => 'classes',
    'merge'         => 'unique',
    'default_value' => []
  }).include

  # Classification option 2 - Classic roles and profiles classes
  $role = $trusted['extensions']['pp_role']
  info("Applying catalog for role ${role}")
  include "::role::${role}"
}
