require 'faker'

FactoryGirl.define do

  factory :course do
    name { "Math" }
    start_date 1.month.ago
    end_date 1.month.from_now
    user
  end

  factory :course_with_lesson_plans, parent: :course do
    name { ["Math", "English I",
      "English II", "Chemistry"].sample }
    start_date 1.month.ago
    end_date 1.month.from_now

    after(:create) do |course|
      (course.start_date..course.end_date).each do |d|
        if d.wday % 2 != 0
          FactoryGirl.create :lesson_plan,
            start: d.to_datetime,
            end: 1.hour.since(d.to_datetime),
            course: course
        end
      end
    end
  end

  factory :invalid_course, parent: :course do |f|
    f.name nil
  end

  factory :course_with_lesson_plan, parent: :course do
    name { "Math" }
    start_date 1.month.ago
    end_date 1.month.from_now
    after(:create) do |c|
      FactoryGirl.create(:lesson_plan, course: c)
    end
  end

  factory :course_with_lesson_plan_field, parent: :course do
    name { "Math" }
    start_date 1.month.ago
    end_date 1.month.from_now
    after(:create) do |c|
      FactoryGirl.create(:lesson_plan_with_field, course: c)
    end
  end

end
