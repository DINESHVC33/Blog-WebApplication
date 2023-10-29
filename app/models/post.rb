class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments , dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
end
