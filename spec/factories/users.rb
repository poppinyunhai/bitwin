FactoryGirl.define do
  sequence :username do |n|
    "a#{SecureRandom.hex(6)}#{n}"
  end

  sequence :email do |n|
    "a#{SecureRandom.hex(6)}#{n}@example.com"
  end

  factory :user do
    username
    email
    password              { "password" }
    password_confirmation { "password" }
  end

  factory :user_confirmed, :class => User do
    username
    email
    password              { "password" }
    password_confirmation { "password" }
    confirmed_at          {Time.now}
  end
end
