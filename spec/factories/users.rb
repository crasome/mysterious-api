FactoryGirl.define do
  factory :guest, class: User::Guest
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.words(5).join }

    trait :invalid do
      email "invalid_email"
    end

    factory :registered do
      ignore do
        resource nil
      end

      factory :owner do
      end

      factory :admin do
        admin true
      end
    end
  end
end
