class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  #フォローするuser側からみて、フォローされる側のユーザーを集める。そのため外部キーはfollowing_idとなっている。
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  #中間テーブルをthroughで通してfollowerモデルのユーザーを集めたモデルを、followingsと名付けた。
  has_many :followings, through: :active_relationships, source: :follower
  #フォローされる側から見て、フォロー下側のユーザーを集める。そのため外部キーはfollower_idとなっている。
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  #中間テーブルを通して,followedモデルのユーザーを集めたモデルをfollowerと名づけた。
  has_many :followers, through: :passive_relationships, source: :following
  
  
  attachment :profile_image
  enum sex: {man: 0, woman: 1}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #ログインじに退会済みの人が再度ログインできないようなコード
  #falseの状態ならtrueを返す仕組みにしています！
  
  def active_for_authentication?
    super && is_deleted == false
  end
    
  def followed_by?(user)
    #現ユーザーがこの人をフォローしているかどうか確かめるためのコード
   passive_relationships.find_by(following_id: user.id).present?
  end
end
