module SpecHelpers
  module Authentication
    def as(user)
      sign_in user
      yield
    ensure
      sign_out
    end

    def sign_in(user)
      http_authorization_header user
    end

    def sign_out
      remove_authorization_header
    end

    private
    def http_authorization_header(user)
      basic_auth = ActionController::HttpAuthentication::Basic.encode_credentials(
        user.email, user.password
      )

      if respond_to? :header
        header "AUTHORIZATION", basic_auth
      else
        request.env['HTTP_AUTHORIZATION'] = basic_auth
      end
    end

    def remove_authorization_header
      if respond_to? :header
        example.metadata[:headers].delete "AUTHORIZATION"
      else
        request.env.delete 'HTTP_AUTHORIZATION'
      end
    end
  end
end
