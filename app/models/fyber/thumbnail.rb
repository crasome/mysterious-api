require 'virtus'

module Fyber
  class Thumbnail
    include Virtus.value_object

    values do
      attribute :lowres, String
    end
  end
end
