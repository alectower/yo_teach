require 'faker'

FactoryGirl.define do
  factory :lesson_plan do
  	start = 1.day.from_now.to_datetime
  	start_time { start }
		end_time { 1.hour.since(start).to_datetime }
    description { Faker::Lorem.sentence(1) }
    association :course, factory: :course
  end
end
