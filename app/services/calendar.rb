class Calendar

  attr_reader :view, :date
  private :date

  def initialize(cal_date, view: :month)
    @date = cal_date.to_date
    @view = view.to_sym
  end

  def year
    date.year
  end

  def month
    Date::MONTHNAMES[date.month]
  end

  def next_month
    date.next_month
  end

  def prev_month
    date.prev_month
  end

  def prev_week
    date.prev_week(:sunday)
  end

  def next_week
    date.next_week(:sunday)
  end

  def each_week
    if block_given?
      lessons.each_slice(7) do |week|
        yield week
      end
    else
      lessons
    end
  end

  alias :each_hour :each_week

  def lessons
    @lessons ||= DateLesson.new(date).range(view)
  end
end
