class Message < ApplicationRecord
  belongs_to :user
  belongs_to :photographer
  belongs_to :request
  enum from: { user: 1, photographer: 10 }

  validates :user_id, :photographer_id, :request_id, :content, presence: true

  def sender
    self.user? ? user.name : photographer.name
  end
end
