class Fyber::OfferSerializer < ActiveModel::Serializer
  self.root = "offers"
  attributes :id, :title, :thumbnail, :payout

  def id
    object.offer_id
  end
end
