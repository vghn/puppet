# JQ Profile
class profile::jq {
  # JQ JSON Processor
  $jq_version = hiera('jq_version')
  wget::fetch {'JQ JSON Processor':
    source      => "https://github.com/stedolan/jq/releases/download/jq-${jq_version}/jq-linux64",
    destination => '/usr/local/bin/jq',
  }
  file {'/usr/local/bin/jq':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => [Wget::Fetch['JQ JSON Processor']],
  }
}
