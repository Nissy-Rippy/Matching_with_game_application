class Video < ApplicationRecord
  #今回投稿する動画は1回につき1個という記述
  belongs_to :user
  has_one_attached :video
end
