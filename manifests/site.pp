# Exec defaults:
Exec { path => '/usr/local/bin:/usr/bin:/usr/sbin/:/bin:/sbin' }

# DEFAULT NODE
node default {
  if $trusted["authenticated"] == "remote" {
    if !empty( $trusted['extensions']['pp_role'] ) {
      info("Applying role '${::trusted['extensions']['pp_role']}'...")
      include "::role::${::trusted['extensions']['pp_role']}"
    } else {
      fail('The \'pp_role\' trusted fact could not be found!')
    }
  } elsif $trusted["authenticated"] == "local" {
    if !empty( $role ) {
      info("Applying role '${::role}'...")
      include "::role::${::role}"
    } else {
      fail('The \'role\' fact could not be found!')
    }
  } else {
    fail('Unauthorized node!')
  }
}
