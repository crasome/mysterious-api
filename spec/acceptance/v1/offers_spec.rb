require "acceptance_helper"

resource "Offers" do
  include_context :api, authenticate: false

  module ResponseFields
    def self.included(example)
      example.response_field :id,         "Offer id",                    scope: :offers
      example.response_field :title,      "Offer title",                 scope: :offers
      example.response_field :thumbnail,  "Thumbnail object",            scope: :offers
      example.response_field :payout,     "Amount of virtual currency",  scope: :offers
    end
  end

  module RequestFields
    def self.included(example)
      example.parameter :uid,   "User unique id"
      example.parameter :pub0,  "Custom parameters"
      example.parameter :page,  "Page to request (pagination)"

      example.let(:uid) { offer_request.uid }
      example.let(:pub0) { offer_request.pub0 }
      example.let(:page) { offer_request.page }
      example.let(:offer_request) { build :offer_request }
    end
  end

  get "/offers?uid=:uid&pub0=:pub0&page=:page" do
    include SpecHelpers::VcrDoRequest[:offers]

    include RequestFields

    response_field :offers,  "A collection of offers"
    include ResponseFields

    it_behaves_like :json_compatible
    it_behaves_like :json_api_collection, name: :offers
    example_request "Get a list of offers" do
      offers.each do |expense|
        expect(json_response[:offers]).to include include(
          id: expense.id,
          description: expense.description
        )
      end
    end
  end
end
