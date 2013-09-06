class LessonPlan < ActiveRecord::Base
  belongs_to :course
	validates_presence_of :description, 
												:course, 
												:start_time, 
												:end_time

  def self.monthly_lessons(date_range)
  	includes(:course).where(start_time: date_range).
			order('start_time asc').group_by { |a| a.start_time.to_date }
	end
end
