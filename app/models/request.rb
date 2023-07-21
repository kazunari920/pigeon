class Request < ApplicationRecord
  belongs_to :user
  belongs_to :photographer
  has_many :messages
  enum status: { offered: 0, declined: 1, accepted: 2, completed: 3 }
  after_initialize :set_default_status, :if => :new_record?
  validates :shooting_date, :shooting_location, :budget, :address, :phone_number, presence: true

  def accept
    self.accepted!
  end

  def decline
    self.declined!
  end

  def complete
    self.completed!
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
