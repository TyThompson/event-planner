#GET request: curl http://localhost:4567/calendar -H "AUTHORIZATION: arb"

#POST request: curl -X POST -d'{"title":"tion":"stuff","time":"sometime","location":"somewher"}' http://localhost:4567/calendar -H "AUTHORIZATION: arb"
#

require 'sinatra/base'
require 'httparty'
require 'sinatra/json'
require 'json'
require './Event.rb'
require 'pry'

class EventPlannerApp < Sinatra::Base
    set :logging, true
    set :show_exceptions, false
    error do |e|
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

    get "/calendar" do
        DB[username] ||= []
        json DB[username]
    end

    post "/calendar" do
        body = request.body.read

        begin
            event = Event.new(JSON.parse body)
        rescue
            status 400
            halt "Can't parse json: '#{body}'"
        end
        if event.valid?
            DB[username] ||= []
            DB[username].push event 
            status 200
            binding.pry
            body "Calendar updated with:" 
        else
            status 422
            body "Event not valid"

        end



    end
end

if $PROGRAM_NAME == __FILE__
    EventPlannerApp.run!
end
