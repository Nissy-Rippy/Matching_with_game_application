class RelationshipsController < ApplicationController
  def create
    #フォローするためのコード
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to request.referer
  end
  

  def destroy
    #フォロー解除のコード
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to request.referer
  end
  
  def followings
    @user = User.find_by(params[:id])
    @followings = @user.followings
  end
  
  
  def followers
    @user = User.find_(params[:id])
    @followers = @user.followers
  
  end
end
