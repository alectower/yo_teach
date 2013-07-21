class Calendar
  attr_reader :dates, :date, :month

  def initialize(date = Date.today, builder = DateBuilder)
    @date = date
    @month = Date::MONTHNAMES[date.month]
    @dates = builder.build(first_calendar_date) do |d|
      CalendarCourseDate.new(d)
    end
  end

  def first_calendar_date
    date.beginning_of_month.beginning_of_week.yesterday
  end

end
