class User::Login
  Error = Class.new StandardError
  AuthorizationFailedError = Class.new Error

  class << self
    def authenticate(identifier, password)
      session = User::Session.create! identifier: identifier, password: password
      session.user
    rescue ActiveRecord::RecordInvalid
      raise AuthorizationFailedError, identifier
    end
  end
end
