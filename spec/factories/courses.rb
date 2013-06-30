require 'faker'

FactoryGirl.define do
  factory :course do
    name { Faker::Name.name }
    start_date 4.months.ago
    end_date 1.month.ago
    day_of_week 4
  end

  factory :invalid_course, parent: :course do |f|
    f.name nil
  end
end
