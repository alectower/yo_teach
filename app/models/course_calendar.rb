class CourseCalendar
  attr_reader :dates

  def initialize(opts)
    @courses = opts.fetch(:courses) { [] }
    @date = opts.fetch(:date) { Date.today }
    construct_dates
  end
  
  def current_month
    Date::MONTHNAMES[@date.month]
  end

  private
  
  def construct_dates
    @dates = []
    calendar_day = @date.beginning_of_month.beginning_of_week
    dates << OpenStruct.new(date: calendar_day, courses: courses_for_day(calendar_day))
    34.times do 
      calendar_day = calendar_day.tomorrow
      dates << OpenStruct.new(date: calendar_day, courses: courses_for_day(calendar_day))
    end
  end
  
  def courses_for_day(day)
    courses = []
    @courses.each do |c|
      p c
      courses << c if day.wday == c.day_of_week
    end
    courses
  end
end
