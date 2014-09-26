FactoryGirl.define do
  factory :expense do
    sequence(:description) { |n| "expense #{n}" }
    sequence(:comment) { |n| "comment #{n}" }
    time { Time.now }
    amount 9.99
    association :owner, factory: :user
  end
end
