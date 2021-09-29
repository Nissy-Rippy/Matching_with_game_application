class LikesController < ApplicationController
  def create
    #投稿データを取得
    @post = Post.find(params[:post_id])
    #@post.likes.newとやることにより、likesのpost_idカラムを取得し、user_id: current_user.idとやることにより、likesのuser_idカラムを取得する
    # newでもbuildでもどちらでも可能
    like = @post.likes.new(user_id: current_user.id)
    like.save
    @post.create_notification_like!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = Like.find_by(post_id: @post.id, user_id: current_user.id)
    like.destroy
    redirect_to request.referer
  end
end
