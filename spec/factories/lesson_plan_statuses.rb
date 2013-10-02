# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson_plan_status do
    name 'Status'
    description 'Description'
  end

  factory :lesson_plan_status_empty, parent: :lesson_plan_status do
    name "Empty"
    description "Lesson plan has been started, but contains no content"
  end
end
