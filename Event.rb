class Event 

    attr_reader :event

    def initialize event
       @title = event["title"] 
       @description = event["description"]
       @location = event["location"]
       @time = event["event"]
    end
    
    def valid? 
        true
        
    end



end
