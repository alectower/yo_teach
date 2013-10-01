require 'faker'

FactoryGirl.define do
  factory :lesson_plan do |lp|
    start_datetime = 1.day.from_now.to_datetime
    lp.start { start_datetime }
    lp.end { 1.hour.since start_datetime }
    lp.title { Faker::Lorem.sentence(1) }
    lp.course
  end

  factory :invalid_lesson_plan, parent: :lesson_plan do |lp|
    lp.start { nil }
    lp.end { 1.day.from_now.to_datetime }
    lp.title { nil }
    lp.course
  end

  factory :lesson_plan_with_fields, parent: :lesson_plan do |lp|
    start_datetime = DateTime.now
    lp.start { start_datetime }
    lp.end { 1.hour.since start_datetime }
    lp.title { 'Area' }
    lp.course
    after(:create) do |l|
      %w[
          Objectives
          Activities
          Assessments
          Homework
          Standards
      ].each do |field|
        FactoryGirl.create(:lesson_plan_field, title: field, description: "", lesson_plan: l)
      end
    end
  end

  factory :lesson_plan_with_field, parent: :lesson_plan do |lp|
    start_datetime = DateTime.now
    lp.start { start_datetime }
    lp.end { 1.hour.since start_datetime }
    lp.title { 'Area' }
    lp.course
    after(:create) do |l|
        FactoryGirl.create(:lesson_plan_field, lesson_plan: l)
      end
  end


end
