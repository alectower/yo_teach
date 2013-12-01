class CalendarController < ApplicationController

  def calendar
    render params.fetch(:view) { :month }
  end

end
