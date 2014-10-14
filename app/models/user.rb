class User < ActiveRecord::Base
  validates :email, presence: true,
                    email: true,
                    uniqueness: true

  has_many :expenses, foreign_key: :owner_id

  def self.registered?(email)
    where(email: email).any?
  end

  def has_password?(password)
    self.password == password
  end
end
