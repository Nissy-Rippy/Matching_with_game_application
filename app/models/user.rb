class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  
  
  attachment :profile_image
  enum sex: {man: 0, woman: 1}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #ログインじに退会済みの人が再度ログインできないようなコード
  #falseの状態ならtrueを返す仕組みにしています！
  
  def active_for_authentication?
    super && is_deleted == false
  end
    
end
