class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 同じ人がいいね出来ないようにするためのvalidates
  validates_uniqueness_of :post_id, scope: :user_id
end
