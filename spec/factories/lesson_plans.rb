require 'faker'

FactoryGirl.define do
  factory :lesson_plan do |lp|
    start_datetime = 1.day.from_now.to_datetime
    lp.start { start_datetime }
    lp.end { 1.hour.since start_datetime }
    lp.title { 'Area' }
    lp.course 'Math'
    lp.user
  end

  factory :invalid_lesson_plan, parent: :lesson_plan do |lp|
    lp.start { nil }
    lp.end { 1.day.from_now.to_datetime }
    lp.title { nil }
    lp.user
  end
end
