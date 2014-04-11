FactoryGirl.define do
  factory :user do
    email 'test@site.com'
    password 'password'
    password_confirmation 'password'
    account
  end
end
