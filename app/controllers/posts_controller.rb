  class PostsController < ApplicationController

    def index
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
      @posts = @posts.order(created_at: :desc)
      #find(params[:id])になおす
      @post = Post.find_by(params[:id])
    end

    def new
      @post = Post.new
    end


    def show
      @post = Post.find(params[:id])
      @comment = Comment.find(params[:id])
      #降順の並びにしている
      @comments = @post.comments.order(created_at: :desc)
    end


    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to posts_path
        flash[:notice] = "投稿完了です＾＾いいねが沢山もらえますように💛"
      else
        flash.now[:notice] = "記入ミスの可能性あり～(￣ー￣)ﾆﾔﾘ"
        render :new
      end
    end
   
   def ranking
     @posts = Post.all_ranking
   end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to
      flash[:notice] = "投稿を削除しちゃった(*´σｰ｀)ｴﾍﾍ"
    end
    
  private

    def post_params
      #tag_idsは空の配列を入れてある。沢山作れるようにしている。
      params.require(:post).permit(:description,:post_title,:image, tag_ids: [])
    end

  end