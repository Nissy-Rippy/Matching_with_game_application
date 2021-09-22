class Post < ApplicationRecord

  attachment :image
  validates :description, :post_title, {presence: true}

  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  #投稿がすでにLikeされているか判断するためのメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def create_notification_like!(current_user)
    #↓Notificationのカラムにデータが存在するかどうか （通知を送るユーザー 送られたユーザー ↓post.rbのためidになている。そしてactionはイイネなのでlikeになっている
    tempt = Notification.where(["visited_id = ? and visitor_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, "like"])

    if tempt.blank?
      #この検索コードによりイイネの連打に対して1っかいの通知しか送られないようにしている。
      notification = current_user.active_notifications.new(
        visited_id: user_id,
        post_id: id,
        action: "like"
        )
        #自分の投稿に対するいいねは通知済みにする.通知送る側と受け取る側が同じ
        #つまりvisited = visitor
        if notification.visited_id == notification.visitor_id
          notification.checked == true
        end
        #もし通知が正当な値ならセーブする
        notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    #コメントをselectでuser_idでまとめてあげてからdistinctで重複コードのないようにしている。そして自分のidを集めないようにする。
    tempt_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    #集めてきたコードを一つずつ取り出してあげ、tempt_idの中のuser_idを取得する
    tempt_ids.each do |tempt_id|
      save_notification_comment!(current_user, comment_id, tempt_id["user_id"])
    end
    #まだ誰もコメントしていないときは投稿者にのみ通知する
    save_notification_comment!(current_user, comment_id, user_id) if tempt_ids.blank?
  end
    #ひとつの投稿に対して複数回コメントする可能性がある。複数回通知をする可能性がある。
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      visited_id: visited_id,
      comment_id: comment_id,
      post_id: id,
      action: "comment",
      )
      #自分の投稿に対する通知は、通知済みにしておく
    if notification.visited == notification.visitor_id
       notification.checked == true
    end
      notification.save if notification.valid?
  end
  #TOP５のランキング機能をつけています。
  #groupにてlikeもでるのpost_idカラムを対象にlikeのpost_idの多い順に5つ並べるようなコードになっています。orderのあとはＬikeモデルのpost_idのカラムの数
  #で並び順を決めpluckでidを取得しているている。
  def self.all_ranking
    Post.find(Like.group(:post_id).order("count(post_id) desc").limit(5).pluck(:post_id))
  end

end