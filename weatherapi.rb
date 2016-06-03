require 'json'
require './token'
require 'pry'
require 'HTTParty'
require 'Date'
require 'Time'


def fetch_weather(zipcode)
	print "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=#{@token2}&q=#{zipcode}&tp=24&format=json"
	HTTParty.get("http://api.worldweatheronline.com/premium/v1/weather.ashx?key=#{@token2}&q=#{zipcode}&tp=24&format=json")
	# data = JSON.parse File.read '.\plannerdata.json'
  #date format is yy-mm-dd
end

# def check_call
# 	HTTParty.get("http://api.worldweatheronline.com/premium/v1/weather.ashx?key=2528be4ba1064395877155302160306&q=48.85,2.35&num_of_days=1&tp=3&format=json")
# end

def rain_chance(fetch_data, days)
  # Time.strftime ("date") - Time.now.strftime("%m-%d")
  # modifier = (endDate - beginDate).to_i
	fetch_data['data']['weather'][days]['hourly'][0]['chanceofrain']
end

def avg_high(fetch_data, days)
	fetch_data['data']['weather'][days]['maxtempF']
end

def avg_low(fetch_data, days)
	fetch_data['data']['weather'][days]['mintempF']
end

def date_math(month, day)
  endDate = Date.new(2016,month,day)
  beginDate = DateTime.now
  days = (endDate - beginDate).to_i
end


#15 days or greater don't get weather
					# Date example 06020602
					#              MMDD-MMDD

fetch_data = fetch_weather("27703")
days = date_math(06, 06)
#               month, day
# out_of_calls = JSON.parse File.read 'out_of_calls.json'
# dummy_data = JSON.parse File.read 'plannerdata.json'
# binding.pry
# if fetch_data.to_json == out_of_calls.to_json
# 	puts "Using dummy data, we are out of calls"
# 	fetch_data = dummy_data
# else
# 	puts "Using real data"
# 	fetch_data
# end
puts "Rain Chance: ", rain_chance(fetch_data, days)
puts "Avg High: ", avg_high(fetch_data, days)
puts "Avg Low: ", avg_low(fetch_data, days)
