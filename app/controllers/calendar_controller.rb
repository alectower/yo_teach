class CalendarController < ApplicationController
  def index
    calendar_stub = Struct.new(:current_month, :days)
    day = Struct.new(:date, :courses, :today)
    course = Struct.new(:name)
    days = []
    date = Date.today
    first_date_of_month = first_of_month(date)
    days_in_previous_month = date.last_month.at_end_of_month.day
    show_start_date = (days_in_previous_month - first_date_of_month.wday + 1)
    calendar_dates = (show_start_date..days_in_previous_month).to_a + (1..date.at_end_of_month.day).to_a
    calendar_dates.each do |num|
      days << day.new(num, [course.new('Math'), course.new('English')], date.day == num)
    end
    @calendar = calendar_stub.new('May', days)
  end

:private
  
  def first_of_month(date)
    date.send :days_ago, (date.day - 1)
  end

end
