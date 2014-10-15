module V1
  class ApiController < ActionController::API
    include ActionController::Serialization
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::MimeResponds

    before_action :authenticate

    rescue_from(User::Login::AuthorizationFailedError) { request_authentication }

    protected
    attr_reader :current_user

    def authenticate
      @current_user = authenticate_with_http_basic do |name, password|
        User::Login.authenticate name, password
      end || raise(User::Login::AuthorizationFailedError)
    end

    # TODO: extract .render_* methods to module or replace by respond_with
    def render(*)
      respond_to do |format|
        format.jsonapi { super }
        format.json { super }
      end
    end

    def render_errors(model)
      render json: RecordErrorsSerializer.new(model).to_json, status: :unprocessable_entity
    end

    def render_model(model, **options)
      if model.valid?
        return head :no_content if :no_content == options[:status]

        render json: model, **options
      else
        render_errors model
      end
    end

    def request_authentication
      headers["WWW-Authenticate"] = 'xBasic realm="Application"'
      self.response_body = "HTTP Basic: Access denied.\n"
      self.status = 401
    end
  end
end
