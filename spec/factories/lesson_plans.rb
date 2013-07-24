require 'faker'

FactoryGirl.define do
  factory :lesson_plan do
    description { Faker::Lorem.sentence(1) }
    date { 1.day.from_now}
    objectives { Faker::Lorem.sentence(1) }
    lesson_steps { Faker::Lorem.sentence(1) }
    association :course, factory: :course
  end
end
