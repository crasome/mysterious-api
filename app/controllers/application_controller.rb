class ApplicationController < ActionController::API
  include ActionController::Serialization
  include Pundit
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  rescue_from(Pundit::NotAuthorizedError) { head :forbidden }

  protected
  attr_reader :current_user

  def authenticate
    @current_user = authenticate_with_http_basic do |name, password|
      User::Login.authenticate name, password
    end || User::Guest.new

  rescue User::Login::AuthorizationFailedError
    request_http_basic_authentication
  end
end
