module UiInteractions::UserSession
  def session
    OpenStruct.new({
      :login_form => "#new_user",
      :registration_form => "#new_user",
      :login_button => "Log in",
      :registration_button => "Sign up",
      :user_session_info => ".user-session-info",
    })
  end

  def log_out
    http_delete destroy_user_session_path
  end

  def log_in(user)
    visit new_user_session_path
    fill_and_submit_login_form user
  end

  def register(user)
    visit new_user_registration_path
    fill_and_submit_registration_form user
  end

  private
  def fill_and_submit_login_form(user)
    within session.login_form do
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password

      click_button session.login_button
    end
  end

  def fill_and_submit_registration_form(user)
    within session.registration_form do
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      fill_in "user_password_confirmation", :with => user.password_confirmation

      click_button session.registration_button
    end
  end
end
