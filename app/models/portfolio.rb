class Portfolio < ApplicationRecord
  belongs_to :photographer
  has_many_attached :images
end
