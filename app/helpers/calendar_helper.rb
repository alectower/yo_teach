module CalendarHelper
  def date_class(date)
    date.today? ? 'today' : 'date'
  end

  def weekly_heading
    params[:view] == 'week' ? 'weekly-heading' : ''
  end

  def day(day)
    day_name = day.to_s.camelize
    if params[:view] == 'week'
      day_with_date(day_name)
    else
      day_name
    end
  end

  def day_with_date(day)
    if params[:date]
      date = Date.strptime(params[:date], "%m/%d/%Y").
        beginning_of_week(:sunday)
    else
      date = Date.today.beginning_of_week(:sunday)
    end
    dates = (date..6.days.since(date)).map { |d| d.day }
    date = dates[Date::DAYNAMES.index(day)]
    "#{date} #{day}"
  end

  def hour_format(hour)
    hour.hours.since(Date.new).strftime "%l %p"
  end

  def day_of_week(day)
    Date::DAYNAMES[day]
  end
end
