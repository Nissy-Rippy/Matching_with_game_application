class Group < ApplicationRecord
  attachment :image
  has_many :user_rooms
  has_many :group_users
  has_many :users, through: :group_users
  has_one :room, dependent: :destroy
  validates :name, :introduction, presence: true
  #group 検索classメソッドを利用している。
  def self.search(keywords)
    #部分検索が一番ユーザーにとっていいかなと思いました。検索項目は、genreです。
    if keywords
     where(["genre like?", "%#{keywords}%"])
    else
     Group.all
    end
  end
end
