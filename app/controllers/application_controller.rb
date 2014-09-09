class ApplicationController < ActionController::API
  include ActionController::Serialization
  include Pundit
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  protected
  attr_reader :current_user

  def authenticate
    @current_user = authenticate_with_http_basic do |name, password|
      User::Login.authenticate name, password
    end
  end
end
