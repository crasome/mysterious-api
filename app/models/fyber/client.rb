module Fyber
  class Client
    def initialize(api_params)
    end

    def get_offers(offer_params)
      [Fyber::Offer.new]
    end
  end
end
