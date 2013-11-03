class Calendar

  Date.beginning_of_week = :sunday

  attr_reader :view

  def self.month_dates(date = Date.current)
    start_date = first_of_month(date)
    start_date..start_date.days_since(34).end_of_day
  end

  def self.week_dates(date = Date.current)
    start_date = date.beginning_of_week
    start_date..start_date.days_since(6).end_of_day
  end

  def initialize(cal_date, args = {})
    @date = cal_date.to_date
    @view = args.fetch(:view) { :month }
    @event_type = args.fetch(:event_type) { LessonPlanEvents }
  end

  def year
    @date.year
  end

  def month
    Date::MONTHNAMES[@date.month]
  end

  def next_month
    @date.next_month
  end

  def prev_month
    @date.prev_month
  end

  def prev_week
    @date.prev_week
  end

  def next_week
    @date.next_week
  end

  def each_week
    @event_type.each_week(@date, @view).each do |week|
      yield week
    end
  end

  private

  def self.first_of_month(date)
    date.beginning_of_month.beginning_of_week
  end

end
