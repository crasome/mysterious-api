class User::Session < ActiveType::Object
  attribute :identifier,  :string
  attribute :password,    :string

  attribute :user

  validates :identifier,  presence: true
  validates :password,    presence: true

  validate :authenticate

  def authenticate
    self.user = User.where(email: identifier, password: password).take!
  rescue ActiveRecord::RecordNotFound
    errors.add :user, "Authorization failed"
  end
end
