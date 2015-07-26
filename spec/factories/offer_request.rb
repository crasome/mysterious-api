require 'factory_girl'

FactoryGirl.define do
  factory :offer_request, class: OpenStruct do
    uid { 'player1' }
    pub0 { 'campaign2' }
    page { 1 }

    initialize_with { new attributes }
  end
end
