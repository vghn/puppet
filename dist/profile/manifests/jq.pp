# JQ JSON Processor Profile
class profile::jq(String $version) {
  wget::fetch {'JQ JSON Processor':
    source      => "https://github.com/stedolan/jq/releases/download/jq-${version}/jq-linux64",
    destination => '/usr/local/bin/jq',
  }

  file {'/usr/local/bin/jq':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => [Wget::Fetch['JQ JSON Processor']],
  }
}
