class CalendarService
  
  def initialize(date = Date.today)
    @date = date
  end

  def get_calendar_courses
    calendar_stub = Struct.new(:current_month, :days)
    day = Struct.new(:date, :courses, :today)
    days = []
    date = Date.today
    calendar_dates = (calendar_start_date..days_in_previous_month).to_a + 
      (1..date.at_end_of_month.day).to_a
    calendar_dates.each do |num|
      days << day.new(num, [Course.new({ name: 'Math' }), Course.new({ name: 'English' }) ], date.day == num)
    end
    calendar_stub.new('May', days)
  end

  def days_in_previous_month
    @date.last_month.at_end_of_month.day
  end

  def calendar_start_date
    days_in_previous_month - first_of_month_week_day + 1
  end

  def first_of_month_week_day
    (@date.days_ago @date.day - 1).wday
  end

end
