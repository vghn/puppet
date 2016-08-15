require 'json'
require 'rack/ssl'
require 'sinatra'
require 'sinatra/base'

# Sinatra Application Class
class API < Sinatra::Base
  use Rack::SSL
  configure do
    enable :logging
  end

  # Intitial deployment
  log.info 'Initial deployment'
  deploy

  get '/' do
    'Nothing here! Yet!'
  end

  post '/travis' do
    payload = JSON.parse(params[:payload])
    build   = payload['number']
    branch  = payload['branch']

    verify_travis_request
    async_deploy
    log.info "Deployment requested from build ##{build} for the #{branch} " \
             "branch of repository #{travis_repo_slug}"
    'Deployment started'
  end

  post '/github' do
    payload = request.body.read
    push = JSON.parse(payload)

    verify_github_signature(payload)
    async_deploy
    log.info "Requested by GtiHub user @#{push['sender']['login']}"
    'Deployment started'
  end

  post '/slack' do
    token   = params.fetch('token').strip
    user    = params.fetch('user_name').strip
    channel = params.fetch('channel_name').strip
    command = params.fetch('command').strip
    text    = params.fetch('text').strip

    if token == config['slack_token']
      log.info "Authorized request from slacker @#{user} on channel ##{channel}"
    else
      log.warn "Unauthorized token received from slacker @#{user}"
    end

    case command
    when '/rhea'
      case text
      when 'deploy'
        # Only use the threaded deployment because of the short timeout
        async_deploy
        'Deployment started :thumbsup:'
      else
        "I don't understand '#{text}' :cry:"
      end
    else
      "Unknown command '#{command}' :cry:"
    end
  end

  # Show environment info
  get '/env' do
    protected!
    if params[:json] == 'yes'
      content_type :json
      ENV.to_h.to_json
    else
      'Environment (as <a href="/env?json=yes">JSON</a>):<ul>' +
        ENV.each.map { |k, v| "<li><b>#{k}:</b> #{v}</li>" }.join + '</ul>'
    end
  end

  get '/status' do
    'Alive'
  end
end # class API
