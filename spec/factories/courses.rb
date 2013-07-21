require 'faker'

FactoryGirl.define do

  factory :course do
    name { ["Math", "English I", 
      "English II", "Chemistry"].sample }
    start_date 1.months.ago
    end_date 1.month.from_now

    after(:create) do |course|
      (course.start_date..course.end_date).each do |d|
        if d.wday % 2 != 0
          FactoryGirl.create(:lesson_plan, date: d, course: course)
        end
      end
    end
  end

  
  factory :invalid_course, parent: :course do |f|
    f.name nil
  end
end
