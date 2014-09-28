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
      initialize_with do
        new(attributes).tap do |user|
          resource.owner = user if resource.respond_to? :owner=
        end
      end

      after(:create) do |user, evaluator|
        evaluator.resource.save! if evaluator.resource.respond_to? :id
      end
    end
  end
end
