DateLessons = Struct.new(:date, :lessons) do
	def initialize(date, lessons)
		self.date = date
		self.lessons = lessons || []
	end
end

class Calendar
	attr_reader :date, :dates, :month
	
	def initialize(date = Date.today)
		@date = date
		@month = Date::MONTHNAMES[date.month]
		get_date_lessons(date)
	end

	def get_date_lessons(date)
		first = first_date(date)
		calendar_dates = first..first.days_since(34)
		lessons = retrieve_lessons(calendar_dates)
		@dates = []
		calendar_dates.each do |d| 
			@dates << DateLessons.new(d, lessons[d])
		end
	end

  def retrieve_lessons(calendar_dates)
  	LessonPlan.monthly_lessons(calendar_dates)
	end

  def first_date(date)
    date.beginning_of_month.beginning_of_week.yesterday
  end

end
