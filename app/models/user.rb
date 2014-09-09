class User < ActiveRecord::Base
  validates :email, presence: true,
                    email: true,
                    uniqueness: true

  def to_s
    email
  end
end
