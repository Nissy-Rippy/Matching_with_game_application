class Group < ApplicationRecord
  attachment :image
  has_many :group_users
  has_many :users, through: :group_users
  
  def self.search(keywords)
    where(["genre like?", "%#{keywords}%"])
  end
end
