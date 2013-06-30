class CalendarController < ApplicationController
  
  def index
    courses = Course.order(:day_of_week)  
    @calendar = CourseCalendar.new(courses: courses)
  end
  
end
