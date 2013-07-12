require 'faker'

FactoryGirl.define do

  factory :course do
    name { ["Math", "English I", "English II", "Chemistry"].sample }
    start_date 4.months.ago
    end_date 1.month.from_now
  end

  factory :invalid_course, parent: :course do |f|
    f.name nil
  end
end
