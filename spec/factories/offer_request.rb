require 'factory_girl'

FactoryGirl.define do
  factory :offer_request, class: OpenStruct do
    uid { 123 }
    pub0 { 'test2' }
    page { 1 }

    initialize_with { new attributes }
  end
end
