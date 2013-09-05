require 'faker'

FactoryGirl.define do
  factory :lesson_plan do
  	start = 1.day.from_now
  	start_time { start }
		end_time { 1.hour.since(start) }
    description { Faker::Lorem.sentence(1) }
    association :course, factory: :course
  end
end
