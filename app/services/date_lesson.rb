class DateLesson

  attr_reader :user, :date
  private :user, :date

  def initialize(user, date)
    @user = user
    @date = date
  end

  def range(view)
    date_range = CalendarDates.send "#{view}_dates", date
    if view == :week
      user.lesson_plans.in_date_range(date_range).
        chronological
    else
      lessons = LessonPlanQuery.new(user.lesson_plans).
        range date_range
      date_lessons date_range, lessons
    end
  end

  private

  DateLessons = Struct.new(:date, :lessons)

  def date_lessons(dates, lessons)
    date_lessons = []
    dates.each do |date|
      date_lessons << DateLessons.new(date, lessons[date] || [])
    end
    date_lessons
  end

end
