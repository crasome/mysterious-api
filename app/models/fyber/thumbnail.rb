require 'virtus'

module Fyber
  class Thumbnail
    include Virtus.value_object
    include ActiveModel::SerializerSupport

    values do
      attribute :lowres, String
    end
  end
end
