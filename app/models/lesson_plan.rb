class LessonPlan < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :fields, foreign_key: 'lesson_plan_id',
    class_name: 'LessonPlanField', dependent: :destroy

  accepts_nested_attributes_for :fields,
    reject_if: :empty_attrs

  has_and_belongs_to_many :core_standards
  accepts_nested_attributes_for :core_standards

  validates_presence_of :title, :course, :start, :end,
    :course_id, :status, :user
  validates_inclusion_of :status, in: 1..3
  before_validation :update_status

  scope :in_date_range, ->(date_range) { where(start: date_range) }
  scope :by_title, ->(title) { where('lower(title) like ?', "%#{title}%") }
  scope :by_course, ->(id) { where(course_id: id) }
  scope :chronological, -> { order('start asc') }

  TIME_FORMAT = "%I:%M %p"

  EMPTY = 1
  IN_PROGRESS = 2
  COMPLETE = 3

  def course_name
    course.name
  end

  def start_date
    start.to_date
  end

  def start_time
    start.strftime(TIME_FORMAT)
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
