class User < ActiveRecord::Base
  validates :email, presence: true,
                    email: true

  def to_s
    email
  end
end
