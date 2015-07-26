module UiInteractions
  module Offers
    def offers
      OpenStruct.new(
        list: '.offers',
        form: '.offers-form',
        list_button: '.offers-form__submit'
      )
    end

    def request_offers(offer_request)
      within offers.form do
        fill_in "offer_request_uid", with: offer_request.uid
        fill_in "offer_request_pub0", with: offer_request.pub0
        fill_in "offer_request_page", with: offer_request.page

        page.find(offers.list_button).click
      end
    end
  end
end
