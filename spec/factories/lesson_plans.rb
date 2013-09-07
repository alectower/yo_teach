require 'faker'

FactoryGirl.define do
  factory :lesson_plan do
  	start = 1.day.from_now.to_datetime
  	start_time { start }
		end_time { 1.hour.since(start) }
    description { Faker::Lorem.sentence(1) }
    course
  end

  factory :invalid_lesson_plan, parent: :lesson_plan do
  	start_time { nil }
		end_time { 1.day.from_now.to_datetime }
		description { nil }
		course
	end
end
