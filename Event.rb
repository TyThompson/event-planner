require './app.rb'


class Event

    attr_reader :title, :date, :zipcode, :time

    def initialize event
        @title = event["title"]
        @date = event["date"]
        @zipcode = event["zipcode"]
        @time = event["time"]


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

    # def fetch_weather zipcode, date
    #
    # end

end
