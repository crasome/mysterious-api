require 'virtus'

module Fyber
  class Offer
    include Virtus.value_object

    values do
      attribute :offer_id, Integer
      attribute :thumbnail, Thumbnail
      attribute :payout, Integer
    end
  end
end
