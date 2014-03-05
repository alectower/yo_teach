module CalendarHelper

  def month_view
    Calendar.new calendar_date
  end

  def week_view
    Calendar.new calendar_date, view: :week
  end

  def date_class(date)
    date.today? ? 'today' : 'date'
  end

  def calendar_class
    params[:view] == 'week' ? 'calendar-week' : 'calendar'
  end

  def calendar_heading
    params[:view] == 'week' ? 'weekly-heading' : ''
  end

  def is_hour?(minute)
    minute % 60 == 0
  end

  def hour_format(minute)
    hour = minute / 60.0
    hour.hours.since(Time.now.beginning_of_day).strftime "%l %p"
  end

  def day_of_week(day)
    Date::DAYNAMES[day]
  end

  def calendar_date
    !params[:date].blank? ?
      DateTime.parse(params[:date]) :
        DateTime.now.beginning_of_day
  end

end
