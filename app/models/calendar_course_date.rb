class CalendarCourseDate
  attr_accessor :date, :courses

  def initialize(date)
    @date = date
    @courses = CourseDay.joins(:course).where(day_of_week: date.wday).map { |c| c.course }
  end

end
