require 'open-uri'
require 'json'

# location = data.json
# current conditions api example = 'http://api.wunderground.com/api/4fea5ef877495d40/geolookup/conditions/q/IA/Cedar_Rapids.json'
location = CurrentConditionsDurham.json

open('location') do |f|
  json_string = f.read
  parsed_json = JSON.parse(json_string)
  location = parsed_json['location']['city']
  temp_f = parsed_json['current_observation']['temp_f']
  print "Current temperature in #{location} is: #{temp_f}\n"
end
