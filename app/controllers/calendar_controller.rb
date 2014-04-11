class CalendarController < ApplicationController

  def calendar
    view = view_params[:view] || :month
    calendar = Calendar.new user: current_user,
     date: calendar_date, view: view
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
    date = params[:date]
    return Date.strptime(date, "%m/%d/%Y") if date
    Date.today
  end

end
