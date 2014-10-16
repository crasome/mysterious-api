class Expense < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  validates :amount,
    presence: true,
    format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
    numericality: { greater_than: 0 }

  validates :time,
    presence: true,
    date: true

  validates :comment,
    length: { minimum: 1, maximum: 1000 }, allow_blank: true

  validates :description,
    length: { minimum: 1, maximum: 200 }, allow_blank: false

  scope :owned, -> user { where owner: user }
end
