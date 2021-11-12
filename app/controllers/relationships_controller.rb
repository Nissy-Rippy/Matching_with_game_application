class RelationshipsController < ApplicationController
  def create
    # フォローするためのコード
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    @user = User.find(params[:user_id])
    #通知のためのコード
    @user.create_notification_follow!(current_user)
  end

  def destroy
    # フォロー解除のコード＝カレントユーザーのフォローした相手側のユーザ情報を特定して削除している。
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    @user = User.find(params[:user_id])
  end
    #followingsはuserモデルに記載されている
  def followings
    @user = User.find(params[:user_id])
    @followings = @user.followings
  end
  #followersはuserモデルに記載されている。
  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers
  end
fi
  def index
    @user = User.find(params[:user_id])
    #このコードにより、マッチングした相手の情報を取得している,
    #34行目の記述で、カレントユーザーがフォローしたフォロワーのユーザー情報を取得してる.
    #35行目で取得してきたフォローワーの中に、カレントユーザーをフォローしてくれたくれた人の情報をselectで探しその相手の情報を取得している。
    #relationsには相互フォローしている人のデータを格納している。
    relations = Relationship.where(following_id: Relationship.where(following_id: current_user.id).pluck(:follower_id))
                            .select { |r| r.follower_id == current_user.id }
                            .pluck(:following_id)
    if relations.present?
      @users = User.find(relations)
    end
  end
end
