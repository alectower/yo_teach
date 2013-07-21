class CalendarController < ApplicationController
  
  def month
    @to_dos = ToDo.all
    @calendar = Calendar.new year_month
    render :calendar
  end

  def year_month
    year = params[:year].to_i
    month = params[:month].to_i
    year != 0 && month != 0 ? Date.new(year,month,1) : Date.today
  end
end
