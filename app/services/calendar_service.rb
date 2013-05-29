class CalendarService
  
  def initialize(date = Date.today)
    @date = date
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
