class Calendar
  attr_reader :dates, :current_month

  def initialize(date = Date.today, builder = DateBuilder)
    @current_month = Date::MONTHNAMES[date.month]
    @dates = builder.build(first_calendar_date(date)) do |d|
      CalendarCourseDate.new(d)
    end
  end

  def first_calendar_date(date)
    date.beginning_of_month.beginning_of_week.yesterday
  end

end
