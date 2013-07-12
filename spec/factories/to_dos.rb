require 'faker'

FactoryGirl.define do
  factory :to_do do
    body { Faker::Lorem.sentence(1) }
    complete { rand(1) == 1 ? true : false }
  end
end
