class User::Session < ActiveType::Object
  attribute :identifier,  :string
  attribute :password,    :string

  attribute :user

  validates :identifier,  presence: true
  validates :password,    presence: true

  validate :validate_user_exists
  validate :validate_password_correct

  def user
    attributes["user"] ||= User.where(email: identifier).take
  end

  private

  def validate_user_exists
    if user.blank?
      errors.add :identifier, 'User with such identifier not found'
    end
  end

  def validate_password_correct
    return if errors.any?
    unless user.has_password? password
      errors.add :password, 'Incorrect password'
    end
  end
end
