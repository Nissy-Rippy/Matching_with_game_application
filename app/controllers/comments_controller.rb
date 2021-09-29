class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    #カレントユーザが作成したコメントを投稿画像と関連付けるための記述
    comment.post_id = @post.id
    if comment.save
      #saveできたのなら通知を送りますよというこーど
      @post.create_notification_comment!(current_user, comment.id)
    end
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end
  
private

  def comment_params
    params.require(:comment).permit(:content, :rate)
  end
end
