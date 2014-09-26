class DateLesson

  attr_reader :user, :date
  private :user, :date

  def initialize(user, date)
    @user = user
    @date = date
  end

  def in_range(view)
    date_range = CalendarDates.send "#{view}_dates", date
    if view == :week
      weekly_lesson_plans(date_range)
    else
      monthly_lesson_plans(date_range)
    end
  end

  private

  def weekly_lesson_plans(range)
    user.lesson_plans.in_date_range(range).chronological
  end

  def monthly_lesson_plans(range)
    query = LessonPlanQuery.new user.lesson_plans
    lessons = query.in_range range
    date_lessons range, lessons
  end

  DateLessons = Struct.new(:date, :lessons)

  def date_lessons(dates, lessons)
    date_lessons = []
    dates.each do |date|
      lessons_ary = lessons[date] || []
      date_lessons << DateLessons.new(date, lessons_ary)
    end
    date_lessons
  end

end
