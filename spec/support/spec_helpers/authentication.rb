module SpecHelpers
  module Authentication
    def sign_in(user)
      http_authorization_header user
    end

    private
    def http_authorization_header(user)
      return remove_authorization_header if user.is_a? User::Guest

      header "AUTHORIZATION", ActionController::HttpAuthentication::Basic.encode_credentials(
        user.email, user.password
      )
    end

    def remove_authorization_header
      example.metadata[:headers].delete "AUTHORIZATION"
    end
  end
end
