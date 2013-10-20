class DateLessons

  def initialize(date = Date.current)
    @date = date
  end

  def range(duration)
    dates = Calendar.send("#{duration}_dates", @date)
    date_lessons dates, LessonPlanQuery.new.range(dates)
  end

  private

  def date_lessons(dates, lessons)
    date_lessons = []
    dates.each do |date|
      date_lessons << Struct.new(:date, :lessons)
        .new(date, lessons[date] || [])
    end
    date_lessons
  end

end
