FactoryGirl.define do
  factory :folder do
    sequence(:name) { |n| "Folder #{n}" }
    association :owner, factory: :user
  end
end
