FactoryGirl.define do
  factory :document do
    sequence(:name) { |n| "Document #{n}" }
    association :owner, factory: :user
  end
end
