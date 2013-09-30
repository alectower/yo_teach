class CalendarController < ApplicationController

  def month
    @to_dos = ToDo.all
    @calendar = Calendar.new(calendar_date)
    render :calendar
  end

  private

  def calendar_date
    year = params[:year].to_i
    month = params[:month].to_i
    year != 0 && month != 0 ?
      DateTime.new(year, month, 1) :
        DateTime.now.beginning_of_day
  end

end
