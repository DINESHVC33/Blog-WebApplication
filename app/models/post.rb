class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments , dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  paginates_per 3
  has_many :ratings
  has_one_attached :image
  belongs_to :user
  has_many :posts_users_read_statuses
  has_many :readers, through: :posts_users_read_statuses, source: :user
  def marked_as_read?(user)
    readers.includes([:readers]).include?(user)
  end
  def mark_as_read(user)
    posts_users_read_statuses.find_or_create_by(user: user).update(read: true)
  end
  scope :filter_by_date, ->(from_date, to_date) {
    where(created_at: from_date.beginning_of_day..to_date.end_of_day)
  }
  after_create :update_rating_average
  def update_rating_average
    update_column(:rating_average, ratings.average(:value))
  end
end
