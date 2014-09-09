FactoryGirl.define do
  factory :guest, class: User::Guest do
    ignore { resource nil }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.words(5).join }

    trait :invalid do
      email "invalid_email"
    end

    factory :registered do
      ignore { resource nil }

      factory :owner do
        initialize_with { resource.is_a?(User) ? resource : new(attributes)  }
      end

      factory :admin do
        admin true
      end
    end
  end
end
