FactoryGirl.define do
  factory :session, class: User::Session do
    user
    identifier { user.email }
    password { user.password }
  end
end
