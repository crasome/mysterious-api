steps_for :user_session do
  include UiInteractions::UserSession

  # Given
  step "I am registered user" do
    @user = create :user
  end

  step "I am logged in" do
    @user ||= create :user
    log_in @user
  end

  # When
  step "I logout" do
    log_out
  end

  step "I login" do
    log_in @user
  end

  step "I register" do
    @user = build_stubbed :user
    register @user
  end

  # Then
  step "I should be on login page" do
    be_on login_path
  end

  step "I should be logged in" do
    within session.user_session_info do
      expect(page).to have_content @user.email
      expect(page).to have_content "logout"
    end
  end

  step "I should be logged out" do
    within session.user_session_info do
      expect(page).to have_content "login"
      expect(page).to have_content "register"
    end
  end

  step "my account should be created" do
    sleep 0.1 # HACK
    expect(User).to be_registered @user.email
  end
end
