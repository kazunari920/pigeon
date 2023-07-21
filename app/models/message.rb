class Message < ApplicationRecord
  belongs_to :messageable, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :request
  before_create :check_request_status


  validates :content, presence: true

  private

  def check_request_status
    unless request.accepted?
      errors.add(:base, "リクエストがまだ承認されていません。")
      throw :abort
    end
  end
end
