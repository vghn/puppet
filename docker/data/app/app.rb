require 'json'
require 'rack/ssl'
require 'sinatra'
require 'sinatra/base'

# Sinatra Application Class
class DataAgent < Sinatra::Base
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

  get '/status' do
    'OK'
  end

  # Deploy (/deploy?async=yes)
  # Simulate a github post:
  # data='{ "repository": { "name": "puppet" }, "ref": "refs/heads/production" }'
  # curl -d "$data" -H "Accept: application/json" 'https://{USER}:{PASS}@localhost:8523/deploy?async=yes' -k -q
  post '/deploy' do
    protected!

    payload = request.body.read
    push = JSON.parse(payload)

    verify_signature(payload) if params[:verify] == 'yes'

    if params[:async] == 'yes'
      async_deploy
    else
      deploy
    end

    log.info "Requested by @#{push['sender']['login']}"
    'Deployment in progress...'
  end

  post '/slack' do
    token   = params.fetch('token').strip
    user    = params.fetch('user_name').strip
    channel = params.fetch('channel_name').strip
    command = params.fetch('command').strip
    text    = params.fetch('text').strip

    if token == config['slack_token']
      log.info "Authorized request from @#{user} on channel ##{channel}"
    else
      log.warn "Unauthorized token received from @#{user}"
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
end # class DataAgent
