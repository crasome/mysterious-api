# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.words(5).join }

    trait :invalid do
      email "invalid_email"
    end
  end
end
