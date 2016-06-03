#curl http://localhost:4567/calendar -H "AUTHORIZATION: arb"
#curl -X POST -d'{"title": "another event","date":"04044444","time":"sometime","zipcode":"06405"}' http://localhost:4567/calendar -H "AUTHORIZATION: arb"
#curl -X DELETE -d '{"title":"new"}' http://localhost:4567/calendar -H "AUTHORIZATION: arb"

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

    def print_calendar
        array = []
        DB[username].each do |event|
            array.push event.title
        end
        return array
    end


    get "/calendar" do
        DB[username] ||= [] 
        calendar = print_calendar
        json calendar
    end

    get "/calendar/:title" do
        DB[username] ||= [] 
         if :title 
             event = existing_item = DB[username].find { |i| i.title == title}
            weather = display_weather (date,zip)
            status 200
            body weather 
        else
            status 404
        end

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
            body "Calendar updated with: #{event.title} at #{event.time} on #{event.date} at #{event.zipcode}\n"
        else
            status 422
            body "Event not valid"

        end
    end

    delete "/calendar" do
        title = request.body.read
        DB[username] ||= []
        existing_item = DB[username].find { |i| i.title == title}
        
        if existing_item
            DB[username].delete existing_item
            status 200
            body "#{title} deleted!"
        else
            status 404
        end
    end

    def display_weather(month, day, zip)
        fetch_data = fetch_weather("zip")
        days = date_math(month, day)
        if date_math(month, day) < 13
            print "Avg High: ", max_temp(fetch_data, days)
            puts
            print "Avg Low: ", min_temp(fetch_data, days)
            puts
            print "Rain Chance: ", rain_chance(fetch_data, days)
        else
            print "Can only check weather 2 weeks in advance."
        end
    end   


end


if $PROGRAM_NAME == __FILE__
    EventPlannerApp.run!
end
