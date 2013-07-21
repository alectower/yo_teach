class CalendarCourseDate
  attr_accessor :date, :lessons

  def initialize(date)
    @date = date
    @lessons = LessonPlan.joins(:course).where(date: date)
  end

end
