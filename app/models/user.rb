class User < ActiveRecord::Base
  validates :email, presence: true,
                    email: true,
                    uniqueness: true
end
