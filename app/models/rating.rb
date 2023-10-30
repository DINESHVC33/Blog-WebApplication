class Rating < ApplicationRecord
  belongs_to :post ,dependent: :destroy

end
