require 'json'
require './token'
require 'pry'
require 'HTTParty'

# Date example 06020602
#              MMDD-MMDD
def fetch_weather(zipcode,date)
	return HTTParty.get("http://api.wunderground.com/api/#{@token}/planner_#{date}/q/#{zipcode}.json")
end

def rain_chance(fetch_data)
	fetch_data['trip']['chance_of']['chanceofprecip']['percentage']
end

def avg_high(fetch_data)
	fetch_data['trip']['temp_high']['avg']['F']
end

def avg_low(fetch_data)
	fetch_data['trip']['temp_low']['avg']['F']
end

fetch_data = fetch_weather(27703,06020602)
puts "Rain Chance: ", rain_chance(fetch_data)
puts "Avg High: ", avg_high(fetch_data)
puts "Avg Low: ", avg_low(fetch_data)
