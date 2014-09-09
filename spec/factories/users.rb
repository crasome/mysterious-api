FactoryGirl.define do
  sequence(:email) { |n| "doctor#{n}.who@example.com" }

  factory :user do
    email
    password { 'secret' }

    trait :invalid do
      email 'invalid_email'
    end

    trait :registered do
      ignore { resource nil }
    end

    trait :owner do
      registered
      initialize_with { resource.is_a?(User) ? resource : new(attributes)  }
    end

    trait :admin do
      registered
      admin true
    end

    trait :guest  do
      ignore { resource nil }
      ignore { password nil }
      initialize_with { User::Guest.new  }
    end
  end
end
