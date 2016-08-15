require 'logger'
require 'openssl'
require 'yaml'
require 'digest/sha2'

# Logging
def log
  Logger.new(STDOUT)
end

# Configuration
def config
  if (File.exists?(ENV['DATA_CONFIG']))
    $config = YAML.load_file(ENV['DATA_CONFIG'])
  else
    raise "Configuration file '#{ENV['DATA_CONFIG']}' does not exist"
  end
end

# Download VGS Library
def download_vgs
  if ! File.exists?('/opt/vgs/load')
    log.info 'Download VGS'
    `git clone https://github.com/vghn/vgs.git /opt/vgs`
  end
end

# Download the Puppet control repo
def download_vpm
  if ! File.exists?('/opt/vpm/envrc')
    log.info 'Download the Puppet control repo'
    `git clone https://github.com/vghn/puppet.git /opt/vpm`
  end
end

# Download vault
def download_vault
  log.info 'Download vault'
  `aws s3 sync "#{ENV['VAULT_S3PATH']}/" \
    '/etc/puppetlabs/vault/' --delete`
  File.write('/var/local/deployed_vault', Time.now.localtime)
end

# Download Hiera data
def download_hieradata
  log.info 'Download Hiera data'
  `aws s3 sync "#{ENV['HIERA_S3PATH']}/" \
    '/etc/puppetlabs/hieradata/' --delete`
  File.write('/var/local/deployed_hieradata', Time.now.localtime)
end

# Deploy R10K
def deploy_r10k
  log.info 'Deploy R10K'
  `r10k deploy environment --puppetfile`
  File.write('/var/local/deployed_r10k', Time.now.localtime)
end

# Deployment
def deploy
  download_vgs
  download_vpm
  download_vault
  download_hieradata
  deploy_r10k
  log.info 'Deployment finished'
end

# Asynchronous Deployment
def async_deploy
  Thread.new { download_vgs }
  Thread.new { download_vpm }
  Thread.new { download_vault }
  Thread.new { download_hieradata }
  Thread.new { deploy_r10k }
  log.info 'Deployment started in the background'
end

def protected!
  unless authorized?
    response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
    throw(:halt, [401, "Not authorized\n"])
  end
end

def authorized?
  @auth ||=  Rack::Auth::Basic::Request.new(request.env)
  @auth.provided? && @auth.basic? && @auth.credentials &&
  @auth.credentials == [config['user'],config['pass']]
end

def verify_github_signature(payload_body)
  signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), config['github_secret'], payload_body)
  unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    throw(:halt, [500, "Signatures didn't match!\n"])
  end
end

def authorization
  env['HTTP_AUTHORIZATION']
end

def travis_repo_slug
  env['HTTP_TRAVIS_REPO_SLUG']
end

def verify_travis_request
  digest = Digest::SHA2.new.update("#{travis_repo_slug}#{config['travis_token']}")
  unless digest.to_s == authorization
    throw(:halt, [403, "Unauthorized TravisCI request!\n"])
  end
end

