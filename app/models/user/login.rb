class User::Login
  Error = Class.new StandardError
  NotAuthenticatedError = Class.new Error

  class << self
    def authenticate(identifier, password)
      User.where(email: identifier, password: password).take!
    rescue ActiveRecord::RecordNotFound
      raise NotAuthenticatedError, identifier
    end
  end
end
