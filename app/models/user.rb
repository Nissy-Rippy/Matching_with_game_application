class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  #新規投稿の際のルール
  validates :name, :playing_game, :address, :email, :age, :sex, {presence: true}
  validates :age, {numericality: true}
#  validates :address, inclusion: {in: ['都','道','府','県']}


  #ユーザールームを使うことによってuserとroomの多対多の関係を成立させている。
  has_many :user_rooms, dependent: :destroy
  #Userは沢山チャットをするので複数のchatt をする chatは一人のユーザーしか持てない。
  has_many :chats, dependent: :destroy
  #一人のユーザーは複数の投稿をすることができる。投稿は一人のuserしかもてない。
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  #userは沢山のコメントを書くことができて、コメントは一つのusrしかいない、
  has_many :comments, dependent: :destroy
  #userとgroupの中間テーブル
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  #フォローするuser側からみて、フォローされる側のユーザーを集める。そのため外部キーはfollowing_idとなっている。
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  #中間テーブルをthroughで通してfollowerモデルのユーザーを集めたモデルを、followingsと名付けた。
  has_many :followings, through: :active_relationships, source: :follower
  #フォローされる側から見て、フォロー下側のユーザーを集める。そのため外部キーはfollower_idとなっている。
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  #中間テーブルを通して,followedモデルのユーザーを集めたモデルをfollowerと名づけた。
  has_many :followers, through: :passive_relationships, source: :following
  #通知をした人
  has_many :active_notifications, class_name: "Notification", foreign_key: :visitor_id, dependent: :destroy
  #通知を受けた人
  has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy
  #refile機能のためのせってい
  attachment :profile_image
  #enum カラム名 をintegerで設定しています。
  enum sex: {man: 0, woman: 1}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable

  #falseの状態ならtrueを返す仕組みにしています！退会機能においての
  def active_for_authentication?
    super && is_deleted == false
  end
  
  
  def followed_by?(user)
    #現ユーザーがこの人をフォローしているかどうか確かめるためのコード
   passive_relationships.find_by(following_id: user.id).present?
  end
  
  
  def create_notification_follow!(current_user)
    #連打でフォローされても通知は一回しか来ないように対策するために事前に検索している
    tempt = Notification.where("visited_id = ? and visitor_id = ? and action = ?", current_user.id, id, "follow")
    #もし通知が作られていなかったらつくるコード
    if tempt.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,#ここはuserクラスのためid飲みになっている
        action: "follow"
        )
        #自分に対するフォローで自分に通知が来ないようにしている。
        if notification.visited_id == notification.visitor_id
          notification.checked == true
        end
        
        notification.save if notification.valid?
    end
  end
  
  def self.search(keyword)
      #playing_gameカラムのの部分一致検索を行うコード
    if keyword
      where(["playing_game like?", "%#{keyword}%"])
    else
      User.all
    end
  end
  
end
