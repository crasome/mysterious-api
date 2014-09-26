class User < ActiveRecord::Base
  validates :email, presence: true,
                    email: true,
                    uniqueness: true

  has_many :expenses, foreign_key: :owner_id
end
