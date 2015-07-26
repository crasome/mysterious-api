steps_for :offers do
  include UiInteractions::Offers

  # Given
  step "I am on the offers page" do
    visit offers_path
  end

  # When
  step "I request the offers" do
    request_offers @user, page: 1
  end


  step "I should see the offers listed" do
    within offers.list do
      expect(page).to have_content "Test offer"
    end
  end
end
