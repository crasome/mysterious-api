# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.words(5).join }

    ignore do
      resource nil
    end

    trait :invalid do
      email "invalid_email"
    end

    trait :common do

    end

    trait :guest do

    end

    trait :owner do

    end

    trait :admin do

    end
  end
end
