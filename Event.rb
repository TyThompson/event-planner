require './app.rb'



class Event 

    attr_reader :event

    def initialize event
       @title = event["title"] 
       @description = event["description"]
       @location = event["location"]
       @time = event["event"]
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
    
    def desc_valid?
        unless @description == @description.to_i.to_s
            true
        end
    end

    def location_valid?
        unless @location.count != 5 || !@location.is_an_integer?
            true
        end
    end



end
