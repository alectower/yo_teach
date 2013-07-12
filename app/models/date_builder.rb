class DateBuilder

  class << self

    def build(date)
      dates = []
      35.times do 
        dates << yield(date)
        date = date.tomorrow
      end
      dates
    end

  end
  
end
