FactoryGirl.define do
  factory :document do
    sequence(:name) { |n| "Document #{n}" }
  end
end
