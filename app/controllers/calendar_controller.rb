class CalendarController < ApplicationController

  def calendar
    view = params.fetch(:view) { :month }
    calendar = Calendar.new calendar_date, view: view
    render view, locals: { calendar: calendar }
  end

  private

  def calendar_date
    params[:date] ? Time.parse(params[:date]).utc : Time.zone.now
  end

end
