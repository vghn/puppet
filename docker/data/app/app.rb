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
