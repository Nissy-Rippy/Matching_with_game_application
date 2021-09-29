class Relationship < ApplicationRecord
  
  #followerもfollwingも　User モデルとして扱う
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  #uniqunessとscopeを使うことにより、連打しても同じ人がフォローできないように制限をしています
  validates :follower_id, uniqueness: { scope: :following_id }

end
