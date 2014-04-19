FactoryGirl.define do
  factory :user do
    email 'test@site.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :invalid_user, class: User do
    email 'test@site.com'
    password 'password'
  end
end
