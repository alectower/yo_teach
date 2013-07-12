class CalendarController < ApplicationController
  
  def index
    @to_dos = ToDo.all
    @calendar = Calendar.new
  end
  
end
