module CalendarHelper

  def week_class
    params[:view] == 'week' ? 'week' : ''
  end
end
