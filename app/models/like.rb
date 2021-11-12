class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 同じ人がいいね出来ないようにするためのvalidates,連打しても1っかいしかイイネできないようにしている。
validates :post_id, uniqueness: { scope: :user_id }
end
