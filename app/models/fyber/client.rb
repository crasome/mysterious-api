require 'net/http'
require 'json'
require_relative 'offer'

module Fyber
  class Client
    OFFERS_URL = "http://api.sponsorpay.com/feed/v1/offers.json"

    def initialize(api_params)
      @api_params = api_params
    end

    def get_offers(offer_params = {})
      offers_data = load_json get(OFFERS_URL, api_params.merge(offer_params))
      json_offers = offers_data.fetch "offers"

      json_offers.map do |offer_data|
        Fyber::Offer.new offer_data
      end
    rescue KeyError
      []
    end

    private
    attr_reader :api_params

    def get(url, params)
      params.merge! timestamp: Time.now.to_i

      uri = URI(url)
      uri.query = URI.encode_www_form params.merge(
        hashkey: generate_hash(params),
      )
      Net::HTTP.get(uri)
    end

    def load_json(response)
      JSON.parse response
    end

    def generate_hash(params)
      api_key = params.delete :api_key
      api_params = params.sort_by { |name, value| name.to_s }.to_h

      digest [URI.encode_www_form(api_params), api_key].join('&')
    end

    def digest(string)
      Digest::SHA1.hexdigest string
    end
  end
end
