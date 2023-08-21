class Book < ApplicationRecord
  scope :published, -> { where(published: true) }
  scope :by_author, ->(author_name) { where(author: author_name) }

  def publish!
    update(published: true)
  end

  def self.recently_added(num)
    order(created_at: :desc).limit(num)
  end
end
