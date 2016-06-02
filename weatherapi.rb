# require 'open-uri'
require 'json'
require './token'
require 'pry'
require 'httparty'

# location = data.json
# current conditions api example = 'http://api.wunderground.com/api/4fea5ef877495d40/geolookup/conditions/q/IA/Cedar_Rapids.json'
path = '.\data.json'
password = @token
#local file JSON.parse File.read path
#api call open('location')
# JSON.parse File.read 'data.json' do |f|

# def fetch_weather(zipcode)
#   HTTParty.get("http://api.wunderground.com/api/#{password}/geolookup/conditions/q/#{@zipcode}.json")
# end

def fetch_weather_test
  HTTParty.get("http://api.wunderground.com/api/4fea5ef877495d40/geolookup/conditions/q/IA/Cedar_Rapids.json")
end

f = fetch_weather_test
test = f.values_at('weather','temp_f')
  # print "fetching weather stats"
  # location = JSON.parse['location']['city']
  # temp_f = JSON.parse['current_observation']['temp_f']
  # current_weather = JSON.parse['weather']['current_weather']
  # print "Current temperature in #{location} is: #{temp_f}\n"
  # print "Current weather is #{current_weather} and the chance of precipitation is eh..."
binding.pry
