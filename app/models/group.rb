class Group < ApplicationRecord
  attachment :image
  has_many :user_rooms
  has_many :group_users
  has_many :users, through: :group_users
  has_one :room, dependent: :destroy
  def self.search(keywords)
    where(["genre like?", "%#{keywords}%"])
  end
end
