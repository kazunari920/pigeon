# frozen_string_literal: true

class Photographer < ApplicationRecord
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_many :portfolios
  acts_as_taggable

  def self.search_by_tag(tag)
    Photographer.tagged_with(tag)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, length: { maximum: 30 }, presence: true

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, uniqueness: true
  # ,presence: true,
  # format: { with: VALID_EMAIL_REGEX },
end
