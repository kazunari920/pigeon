class Request < ApplicationRecord
  belongs_to :user
  belongs_to :photographer
  has_many :messages
  enum status: { offered: 0, accepted: 1, completed: 2, declined: 3 }
  after_initialize :set_default_status, :if => :new_record?
  validates :shooting_date, :shooting_location, :budget, :address, :phone_number, presence: true

  def accept(photographer)
    return unless can_be_accepted_by?(photographer)

    accepted!
  end

  def decline(photographer)
    return unless can_be_declined_by?(photographer)

    declined!
  end

  def complete(photographer)
    return unless can_be_completed_by?(photographer)

    completed!
  end

  def pending?
    status == 'offered'
  end

  def accepted?
    status == 'accepted'
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



  private

  def set_default_status
    self.status ||= :offered
  end


end
