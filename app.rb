require 'sinatra/base'
require 'sinatra/json'
require 'json'

class EventPlannerApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false
  error do |e|
    binding.pry
    raise e
  end

  DB = {}

  before do
    require_authorization!
  end

  def require_authorization!
    unless username
      status 401
      halt({ error: "You must log in" }.to_json)
    end
  end

  def username
    request.env["HTTP_AUTHORIZATION"]
  end
end


if $PROGRAM_NAME == __FILE__
    EventPlannerApp.run!
end
