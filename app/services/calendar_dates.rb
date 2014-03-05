class CalendarDates

  def self.month_dates(date = Date.current)
    start_date = first_of_month(date).yesterday
    start_date..start_date.days_since(34).end_of_day
  end

  def self.week_dates(date = Date.current)
    start_date = date.beginning_of_week.yesterday
    start_date..start_date.days_since(7)
  end

  def self.first_of_month(date)
    date.beginning_of_month.beginning_of_week
  end

end
