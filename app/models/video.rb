class Video < ApplicationRecord
  #今回投稿する動画は1回につき1個という記述
  belongs_to :user
  has_one_attached :video
  
  def self.search(key_word)
    #空白の時と記入の時での条件分岐
    return Video.all() unless key_word
    Video.where("title like?, %#{key_word}%")
  end

end
