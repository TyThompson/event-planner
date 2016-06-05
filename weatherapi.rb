require 'json'
require 'pry'
require 'HTTParty'
require 'Date'
require 'Time'
require './Event'
require './app.rb'


def fetch_weather(zipcode)
  token = ENV["WEATHER_API_KEY"]
	HTTParty.get("http://api.worldweatheronline.com/premium/v1/weather.ashx?key=#{token}&q=#{zipcode}&tp=24&format=json")
	# data = JSON.parse File.read '.\plannerdata.json'
end

def rain_chance(fetch_data, days)
	fetch_data['data']['weather'][days]['hourly'][0]['chanceofrain']
end

def max_temp(fetch_data, days)
	fetch_data['data']['weather'][days]['maxtempF']
end

def min_temp(fetch_data, days)
	fetch_data['data']['weather'][days]['mintempF']
end

def date_math(month, day)
  endDate = Date.new(2016,month,day)
  beginDate = DateTime.now
  days = (endDate - beginDate).to_i
end

def display_weather(month, day, zip)

  fetch_data = fetch_weather("zip")
  days = date_math(month, day)
  if date_math(month, day) < 13
		maxtemp = max_temp(fetch_data, days)
		mintemp = min_temp(fetch_data, days)
		rain = rain_chance(fetch_data, days)
    return "Avg High: #{maxtemp}, Avg Low: #{mintemp}, Rain Chance: #{rain}"
  #   puts
  #   print "Avg Low: ", min_temp(fetch_data, days)
  #   puts
  #   print "Rain Chance: ", rain_chance(fetch_data, days)
  else
     return "Can only check weather 2 weeks in advance."
  end
end

# display_weather(06,07,'27703')
#month,day,zip

#15 days or greater don't get weather
					# Date example 06020602
					#              MMDD-MMDD

# fetch_data = fetch_weather("27703")
# days = date_math(06, 06)
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
