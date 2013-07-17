require 'faker'

FactoryGirl.define do
  factory :lesson_plan do
    objectives 
    lesson_steps
    standards
    association :course, factory: course
    association :course_day, factory: course_day
  end
end
