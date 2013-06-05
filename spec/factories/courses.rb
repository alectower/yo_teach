require 'faker'

FactoryGirl.define do
  factory :course do |f|
    f.name { Faker::Name.name }
    f.start_date 4.months.ago
    f.end_date 1.month.ago
  end
end