class Request < ApplicationRecord
  belongs_to :user
  belongs_to :photographer
  has_many :messages

  enum status: { offered: 0, declined: 1, accepted: 2, completed: 3 }
  validates :shooting_date, :shooting_location, :budget, :address, :phone_number, presence: true
end
