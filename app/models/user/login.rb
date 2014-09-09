class User::Login
  Error = Class.new StandardError
  AuthorizationFailedError = Class.new Error

  class << self
    def authenticate(identifier, password)
      User.where(email: identifier, password: password).take!
    rescue ActiveRecord::RecordNotFound
      raise AuthorizationFailedError, identifier
    end
  end
end
