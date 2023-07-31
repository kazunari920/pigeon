# frozen_string_literal: true

class User < ApplicationRecord
  include Findable
  has_many :likes
  has_many :liked_photographers, through: :likes, source: :photographer
  has_many :requests
  has_many :messages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, length: { maximum: 30 }, presence: true

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, uniqueness: true
  # presence: true,
  # format: { with: VALID_EMAIL_REGEX },

  def liked?(photographer)
    liked_photographers.exists?(photographer.id)
  end
end
