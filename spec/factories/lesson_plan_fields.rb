# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson_plan_field do
    title "Homework"
    description "Read ch. 1-3"
    lesson_plan
  end
end
