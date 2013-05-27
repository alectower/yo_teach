class CoursesController < ApplicationController
  def index
    calendar_stub = Struct.new(:current_month, :days)
    day = Struct.new(:date, :courses)
    course = Struct.new(:name)
    days = []
    (1..31).each do |num|
      days << day.new(num, [course.new('Math'), course.new('English')])
    end
    @calendar = calendar_stub.new('May', days)
  end
end
