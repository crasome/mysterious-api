module V1
  class OffersController < ApiController
    def index
      load_offers
      render json: @offers
    end

    private
    def load_offers
      @offers = fyber.get_offers **offer_request_params
    end

    def offer_request_params
      params.permit(:uid, :pub0, :page)
    end
  end
end
