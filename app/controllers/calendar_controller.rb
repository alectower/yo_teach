class CalendarController < ApplicationController

  def calendar
    view = params.fetch(:view) { :month }
    calendar = Calendar.new calendar_date, view: view
    render view, locals: { calendar: calendar }
  end

  private

  def calendar_date
    params[:date] ? Date.parse(params[:date]) : Date.today
  end

end
