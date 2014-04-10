class CalendarController < ApplicationController

  def calendar
    view = view_params[:view] || :month
    calendar = Calendar.new calendar_date, view: view
    render view, locals: { calendar: calendar }
  end

  private

  def view_params
    permitted = []
    permitted << :view if is_view_param?
    params.permit *permitted
  end

  def is_view_param?
    %w(week month).include? params[:view]
  end

  def calendar_date
    params[:date] ? Date.strptime(params[:date], "%m/%d/%Y") : Date.today
  end

end
