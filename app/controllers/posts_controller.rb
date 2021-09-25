class PostsController < ApplicationController
  def index
    # tag検索のためのコード、三項演算子になっている。
    @tags = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.includes(:user, :tags, :post_tags) : Post.includes(:user, :tags, :post_tags)
    @posts = @tags.order(params[:sort])
    # find(params[:id])になおす
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  # followしている人の投稿のみを表示するページにしています。
  def edit
    @posts_all = Post.includes(:tags, :post_tags, :user)
    @followings = current_user.followings
    if @followings.present?
      @posts = @posts_all.where(user_id: @followings).order("created_at DESC")

      if @posts.nil?
        redirect_to user_path(current_user)
        flash[:notice] = "( ﾟдﾟ)ﾊｯ!ﾅｲﾀﾞﾄｯ！！"
      end

    else
      redirect_to user_path(current_user)
      flash[:notice] = "ﾌｫﾛｰｼﾃないだと・・・"
    end
  end

  def show
    # コメントフォームにデータを送るための2つのデータ
    @post = Post.find(params[:id])
    @comment = Comment.find(params[:id])
    # 降順の並びにしている
    @comments = @post.comments.order(created_at: :desc).includes(:user)
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
    @posts = Post.includes(:user, :tags, :post_tags).all_ranking
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to
    flash[:notice] = "投稿を削除しちゃった(*´σｰ｀)ｴﾍﾍ"
  end

  private

  def post_params
    # tag_idsは空の配列を入れてある。沢山作れるようにしている。
    params.require(:post).permit(:description, :post_title, :image, tag_ids: [])
  end
end
