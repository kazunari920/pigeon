class Book < ApplicationRecord
  scope :published, -> { where(published: true) }
  scope :by_author, ->(author_name) { where(author: author_name) }

  def publish!
    update(published: true)
  end

  def self.recently_added(n)
    order(created_at: :desc).limit(n)
  end
end
