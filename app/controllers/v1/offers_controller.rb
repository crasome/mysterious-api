module V1
  class OffersController < ApiController
    def index
      load_offers
      render json: @offers
    end

    private
    def load_offers
      @offers = fyber.get_offers offer_request_params
    end

    def offer_request_params
      params.permit(:uid, :pub0, :page)
    end

    def fyber
      Fyber::Client.new(
        appid: 157,
        api_key: "b07a12df7d52e6c118e5d47d3f9e60135b109a1f",
        offer_types: 112,

        device_id: "2b6f0cc904d137be2e1730235f5664094b83",
        locale: "de",
        ip: "109.235.143.113",
        format: :json
      )
    end
  end
end
