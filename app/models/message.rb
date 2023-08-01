class Message < ApplicationRecord
  belongs_to :user
  belongs_to :photographer
  belongs_to :request
  before_create :check_request_status
  enum from: { user: 1, photographer: 10 }

  validates :user_id, :photographer_id, :request_id, :content, presence: true

  def sender
    self.user? ? user.name : photographer.name
  end

  private

  def check_request_status
    return if request.accepted? || request.completed?

    errors.add(:base, 'リクエストが承認されていません。')
    throw :abort
  end
end
