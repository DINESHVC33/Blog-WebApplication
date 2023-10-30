class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments , dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  paginates_per 3
  has_many :ratings
  has_one_attached :image
end
