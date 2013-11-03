module CalendarHelper

  def month_view(cal = Calendar)
    cal.new calendar_date, view: :month
  end

  def week_view(cal = Calendar)
    cal.new calendar_date, view: :week
  end

  def date_class(date)
    date.today? ? 'today' : 'date'
  end

  def day_hours(lessons)
    hours = add_hours(5..11, "AM", lessons)
    hours += add_hours(12..12, "PM", lessons)
    hours += add_hours(1..11, "PM", lessons)
  end

  private

  def add_hours(range, time_period, lessons)
    (range).each_with_object([]) do |time, hours|
      hours << { time: "#{time} #{time_period}",
                 lesson: find_lesson_for_hour(lessons, time_period, time) }
    end
  end

  def find_lesson_for_hour(lessons, time_period, time)
    lessons.each do |lesson|
      return lesson if
        time == military_time(time_period, lesson)
    end
    nil
  end

  def military_time(time_period, lesson)
    if time_period == "AM"
      lesson.start.hour
    else
      lesson.start.hour == 12 ? 12 :
        lesson.start.hour + 12
    end
  end

  def calendar_date
    !params[:date].blank? ?
      DateTime.parse(params[:date]) :
        DateTime.now.beginning_of_day
  end

end
