class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  #ポストタグを経由してpostsの情報を
  has_many :posts, through: :post_tags, dependent: :destroy
end
