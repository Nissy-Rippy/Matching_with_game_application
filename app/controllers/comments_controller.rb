class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    if comment.save
      @post.create_notification_comment!(current_user, comment.id)
    end
    @comments = @post.comments.order(created_at: :desc)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :rate)
  end
end
