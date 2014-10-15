class Expense < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  validates :amount,
    presence: true,
    format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
    numericality: { greater_than: 0 }

  validates :time,
    presence: true,
    date: true

  scope :owned, -> user { where owner: user }
end
