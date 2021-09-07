  class PostsController < ApplicationController
    
    def index
      @posts = Post.all
    end
  
    def new
      @post = Post.new
    end
  
    def show
      @post = Post.find(params[:id])
      @comment = Comment.new
      @comments = @post.comments.order(created_at: :desc)
    end
  
    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to posts_path
        flash[:notice] = "投稿完了です＾＾言い値が沢山もらえますように💛"
      else
        flash.now[:notice] = "記入ミスの可能性あり～(￣ー￣)ﾆﾔﾘ"
        render :new
      end
    end
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      flash[:notice] = "投稿を削除しちゃった(*´σｰ｀)ｴﾍﾍ"
      redirect_to 
    end
  private
  
    def post_params
      params.require(:post).permit(:description,:post_title,:image)
    end
    
  end