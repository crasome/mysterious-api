module UiInteractions::UserSession
  def session
    OpenStruct.new({
      :login_form => ".login-form",
      :registration_form => ".registration-form",
      :login_button => "Log in",
      :registration_button => "Register",
      :user_session_info => ".user-session-info",
    })
  end

  def log_out
    # http_delete destroy_user_session_path
  end

  def log_in(user)
    visit login_path
    fill_and_submit_login_form user
  end

  def register(user)
    visit registration_path
    fill_and_submit_registration_form user
  end

  private
  def fill_and_submit_login_form(user)
    within session.login_form do
      fill_in "identifier", :with => user.email
      fill_in "password", :with => user.password

      click_button session.login_button
    end
  end

  def fill_and_submit_registration_form(user)
    within session.registration_form do
      fill_in "user.email", :with => user.email
      fill_in "user.password", :with => user.password
      fill_in "user.password_confirmation", :with => user.password

      click_button session.registration_button
    end
  end
end
