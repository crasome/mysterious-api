require 'virtus'
require_relative 'thumbnail'

module Fyber
  class Offer
    include Virtus.value_object
    include ActiveModel::SerializerSupport

    values do
      attribute :offer_id,   Integer
      attribute :title,      String
      attribute :thumbnail,  Thumbnail
      attribute :payout,     Integer
    end
  end
end
