class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    #buildはアソシエーションしながらインスタンスをnewしてくれる。
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
