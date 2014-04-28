FactoryGirl.define do
  factory :user do
    name 'Guy'
    email 'test@site.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :invalid_user, class: User do
    name 'Guy'
    email 'test@site.com'
    password 'password'
  end
end
