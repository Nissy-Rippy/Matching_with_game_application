class CommentsController < ApplicationController
  def create
    @post = Post.find_by(params[:id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    
  end
  private
  
  def comment_params
    params.require(:comment).permit(:content,:rate)
  end
  
end
