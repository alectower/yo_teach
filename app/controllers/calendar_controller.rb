class CalendarController < ApplicationController

  def calendar
    if params[:view]
      @calendar = Calendar.new calendar_date,
        view: params[:view].to_sym
    else
      @calendar = Calendar.new calendar_date
    end
    @to_dos = ToDo.all
  end

  private

  def calendar_date
    !params[:date].blank? ?
      DateTime.parse(params[:date]) :
        DateTime.now.beginning_of_day
  end

end
