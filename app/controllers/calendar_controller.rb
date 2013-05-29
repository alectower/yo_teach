require 'calendar_service'

class CalendarController < ApplicationController
  
  def index
    calendar_service = CalendarService.new
    calendar_stub = Struct.new(:current_month, :days)
    day = Struct.new(:date, :courses, :today)
    course = Struct.new(:name)
    days = []
    date = Date.today
    calendar_dates = (calendar_service.calendar_start_date..calendar_service.days_in_previous_month).to_a + 
      (1..date.at_end_of_month.day).to_a
    calendar_dates.each do |num|
      days << day.new(num, [course.new('Math'), course.new('English')], date.day == num)
    end
    @calendar = calendar_stub.new('May', days)
  end

end
