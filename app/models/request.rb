class Request < ApplicationRecord
  belongs_to :user
  belongs_to :photographer
  has_many :messages
  enum status: { offered: 0, accepted: 1, completed: 2, declined: 3 }
  after_initialize :set_default_status, :if => :new_record?
  validates :shooting_date, :shooting_location, :budget, :address, :phone_number, presence: true

  def accept(photographer)
    return false unless can_be_accepted_by?(photographer)

    transaction do
      accepted!
      Message.create!(
        user: self.user,
        photographer: photographer,
        request: self,
        content: photographer.initial_message,
        from: :photographer
      )
    end

    true
  end

  def decline(photographer)
    return false unless can_be_declined_by?(photographer)

    declined!
    true
  end

  def complete(photographer)
    return false unless can_be_completed_by?(photographer)

    completed!
    true
  end

  # ↓TODO: 後ほどenumで作り直す
  # ただしstatusメソッドがあるため、必要なくなる可能性あり
  # ?をつけるのは慣習的にboolean型のメソッドのみ

  def pending?
    status == 'offered'
  end

  def accepted?
    status == 'accepted'
  end

  def completed?
    status == 'completed'
  end

  def declined?
    status == 'declined'
  end
  # ↑ここまで

  # ↓TODO: ?をつけるのは慣習的にboolean型のメソッドのみ、後ほど修正

  def status?
    return 'accepted' if accepted?
    return 'declined' if declined?
    return 'completed' if completed?

    'offered'
  end

  def can_send_to_message?
    return true if accepted?
    return true if completed?

    false
  end

  def can_be_accepted_by?(photographer)
    status == 'offered' && photographer.id == photographer_id
  end

  def can_be_declined_by?(photographer)
    status == 'offered' && photographer.id == photographer_id
  end

  def can_be_completed_by?(photographer)
    status == 'accepted' && photographer.id == photographer_id
  end

  def accessed_by?(user, photographer)
    self.user == user || self.photographer == photographer
  end

  private

  def set_default_status
    self.status ||= :offered
  end
end
