class LessonPlan < ActiveRecord::Base
  belongs_to :course
	validates_presence_of :description, 
												:course, 
												:start, 
												:end

  def self.monthly_lessons(date_range)
  	includes(:course).where(start: date_range).
			order('start asc').group_by(&:start_date)
	end

	TIME_FORMAT = "%I:%M %p"
	def start_date
		read_attribute(:start).to_date
	end

	def start_time
		read_attribute(:start).strftime(TIME_FORMAT)
	end

	def end_time
		read_attribute(:end).strftime(TIME_FORMAT)
	end

end
