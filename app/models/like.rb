class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 同じ人がいいね出来ないようにするためのvalidates
validates :post_id, uniqueness: { scope: :user_id }
end
