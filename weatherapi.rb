require 'json'
require './token'
require 'pry'
require 'HTTParty'


def fetch_weather(zipcode,date)
	HTTParty.get("http://api.wunderground.com/api/#{@token}/planner_#{date}/q/#{zipcode}.json")
	# data = JSON.parse File.read '.\plannerdata.json'
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

					# Date example 06020602
					#              MMDD-MMDD

fetch_data = fetch_weather(27703,06020602)
out_of_calls = JSON.parse File.read '.\out_of_calls.json'
dummy_data = JSON.parse File.read '.\plannerdata.json'
if fetch_data.to_json == out_of_calls.to_json
	fetch_data = dummy_data
	puts "Using dummy data, we are out of calls"
else
	puts "Using real data"
end

puts "Rain Chance: ", rain_chance(fetch_data)
puts "Avg High: ", avg_high(fetch_data)
puts "Avg Low: ", avg_low(fetch_data)

