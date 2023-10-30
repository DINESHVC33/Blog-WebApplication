class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :user_comment_ratings, dependent: :destroy
  has_many :rating_users, through: :user_comment_ratings, source: :user
end
