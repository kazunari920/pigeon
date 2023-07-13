# frozen_string_literal: true

class Portfolio < ApplicationRecord
  belongs_to :photographer
  has_many_attached :images
end
