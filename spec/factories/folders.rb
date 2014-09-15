FactoryGirl.define do
  factory :folder do
    sequence(:name) { |n| "Folder #{n}" }
  end
end
