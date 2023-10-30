class Rating < ApplicationRecord
  belongs_to :post ,dependent: :destroy
  after_create :update_rating_average
  def update_rating_average
    post.update_rating_average
  end
end
