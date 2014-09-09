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

    factory :common
    factory :owner

    factory :admin do
      admin true
    end
  end

  factory :guest, class: User::Guest
end
