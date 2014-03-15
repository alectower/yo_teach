module CalendarHelper

  def date_class(date)
    date.today? ? 'today' : 'date'
  end

  def calendar_class
    params[:view] == 'week' ? 'calendar-week' : 'calendar'
  end

  def calendar_heading
    params[:view] == 'week' ? 'weekly-heading' : ''
  end

  def day(day)
    day_name = day.to_s.camelize
    if params[:view] != 'week'
      day_name
    else
      day_with_date(day_name)
    end
  end

  def day_with_date(day)
    if params[:date]
      date = Date.parse(params[:date]).
        beginning_of_week(:sunday)
    else
      date = Date.today.beginning_of_week(:sunday)
    end
    dates = (date..6.days.since(date)).map { |d| d.day }
    date = dates[Date::DAYNAMES.index(day)]
    "#{date} #{day}"
  end

  def is_hour?(minute)
    minute % 60 == 0
  end

  def hour_format(minute)
    hour = minute / 60
    hour.hours.since(Date.new).strftime "%l %p"
  end

  def day_of_week(day)
    Date::DAYNAMES[day]
  end

end
