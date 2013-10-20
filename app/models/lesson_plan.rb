class LessonPlan < ActiveRecord::Base
  belongs_to :course
  has_many :fields, foreign_key: 'lesson_plan_id',
    class_name: 'LessonPlanField', dependent: :destroy
  accepts_nested_attributes_for :fields,
    reject_if: :empty_attrs
  validates_presence_of :title,
                        :course,
                        :start,
                        :end,
                        :course_id,
                        :status
  validates_inclusion_of :status, in: 1..3
  before_validation :update_status

  TIME_FORMAT = "%I:%M %p"

  EMPTY = 1
  IN_PROGRESS = 2
  COMPLETE = 3

  def course_name
    course.name
  end

  def start_date
    read_attribute(:start).to_date
  end

  def start_time
    read_attribute(:start).strftime(TIME_FORMAT)
  end

  def end_time
    read_attribute(:end).strftime(TIME_FORMAT)
  end

  def status_text
    case self.status
    when EMPTY
      'Empty'
    when IN_PROGRESS
      'In Progress'
    when COMPLETE
      'Complete'
    end
  end

  private

  def empty_attrs(attrs)
    attrs[:title].blank? && attrs[:description].blank?
  end

  def update_status
    self.status = IN_PROGRESS if !fields.empty? && fields.any? { |f| !f.description.blank? }
    self.status = EMPTY if fields.empty? || fields.all? { |f| f.description.blank? }
    self.status = COMPLETE if !fields.empty? && fields.all? { |f| !f.description.blank? }
  end

end
