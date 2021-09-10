class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :item_id, scope: :user_id

end
