class LessonPlan < ActiveRecord::Base
  belongs_to :course

  def self.monthly_lessons(date_range)
  	includes(:course).where(date: date_range).
			order('date asc').group_by(&:date)
	end
end
