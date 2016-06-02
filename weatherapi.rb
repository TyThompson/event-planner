# require 'open-uri'
require 'json'
require './token'
require 'pry'
require 'httparty'

# location = data.json
# current conditions api example = 'http://api.wunderground.com/api/4fea5ef877495d40/geolookup/conditions/q/IA/Cedar_Rapids.json'
# path = '.\data.json'
#local file JSON.parse File.read path
#api call open('location')

def fetch_weather(zipcode)
   HTTParty.get("http://api.wunderground.com/api/#{@token}/geolookup/conditions/q/#{zipcode}.json")
end

def fetch_weather_test
  HTTParty.get("http://api.wunderground.com/api/4fea5ef877495d40/geolookup/conditions/q/IA/Cedar_Rapids.json")
end

temp = fetch_weather_test["current_observation"]["temp_f"]
weather = fetch_weather_test["current_observation"]["weather"]
tempz = fetch_weather(27511)["current_observation"]["temp_f"]
weather = fetch_weather(27511)["current_observation"]["weather"]

binding.pry
