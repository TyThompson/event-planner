require './app.rb'



class Event 

    attr_reader :title, :date, :zipcode, :time  

    def initialize event
        @title = event["title"] 
        @date = event["date"]
        @zipcode = event["zipcode"]
        @time = event["time"]
       # @weather = display_weather(@date[0,1],@date[2,3],@zipcode)
    

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

    def valid? 
        #  if event_valid? && description_valid? && location.valid? && time_valid?
        true
        #   else
        #       false
        #   end
    end 

    def title_valid?
        unless @title == @title.to_i.to_s
        end
    end

    def zipcode_valid?
        unless @location.count != 5 || !@location.is_an_integer?
            true
        end
    end

    def fetch_weather zipcode, date

    end

end
