# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_day do |c| 
    day_of_week 1
    association :course, factory: :course
  end

  factory :course_day_random, parent: :course_day do |c|
    day_of_week { rand(7) }
    association :course, factory: :course
  end
end
