class LessonPlan < ActiveRecord::Base
  belongs_to :course
  has_many :fields, foreign_key: 'lesson_plan_id', class_name: 'LessonPlanField'
  accepts_nested_attributes_for :fields,
    reject_if: proc { |attrs| attrs[:title].blank? && attrs[:description].blank? }
  validates_presence_of :title,
                        :course,
                        :start,
                        :end

  def self.monthly_lessons(date_range)
    includes(:course)
      .where(start: date_range)
      .order('start asc')
      .group_by(&:start_date)
  end

  def self.lesson_plan_with_fields(id)
    includes(:fields, :course)
      .order("lesson_plan_fields.title asc")
      .find(id)
  end

  def course_name
    course.name
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
