class RelationshipsController < ApplicationController
  def create
    # フォローするためのコード
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
  end

  def destroy
    # フォロー解除のコード
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    @user = User.find(params[:user_id])
  end

  def followings
    @user = User.find(params[:user_id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:userid])
    @followers = @user.followers
  end

  def index
    @user = User.find(params[:user_id])
    relations = Relationship.where(following_id: Relationship.where(following_id: current_user.id).pluck(:follower_id)).select { |r| r.follower_id == current_user.id }.pluck(:following_id)
    if relations.present?
      @users = User.find(relations)
    else
      redirect_to user_path(current_user)
      flash[:notice] = "マッチングしてないみたい・・・( ；∀；)"
    end
  end
end
