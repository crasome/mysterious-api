steps_for :offers do
  include UiInteractions::Offers

  # Given
  step "I am on the offers page" do
    visit offers_path
  end

  # When
  step "I request the offers" do
    @offer_request = build :offer_request
    request_offers @offer_request
  end


  step "I should see the offers listed" do
    within offers.list do
      expect(page).to have_content "Gratis Prepaid-SIM"
    end
  end
end
