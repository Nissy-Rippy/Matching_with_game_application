class PostsController < ApplicationController
  before_action :if_not_admin, only:[:destroy]
  def index
    # tag検索のためのコード、三項演算子になっている。N+!問題を解決するデータを結合させて記述になっている。
    @tags = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.includes(:user, :tags, :post_tags) : Post.includes(:user, :tags, :post_tags)
    @posts = @tags.order(params[:sort])
    # find(params[:id])になおす
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  # followしている人の投稿のみを表示するページにしています。
  def edit
    #N+1問題解決のためデータを結合させている。
    @posts_all = Post.includes(:tags, :post_tags, :user)
    #カレントユーザーがフォローしている人のデータ取得
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
    @post = Post.find(params[:id])
    @comment = Comment.new
    # 降順の並びにしている
    @comments = @post.comments.order(created_at: :desc).includes(:user)
  end

  def create
    @post = Post.new(post_params)
    #投稿とユーザー情報を紐付けている
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿完了です＾＾いいねが沢山もらえますように💛"
      redirect_to posts_path
    else
      flash.now[:notice] = "記入ミスの可能性あり～(￣ー￣)ﾆﾔﾘ"
      render :new
    end
  end

  def ranking
    #　N+１問題解消のためデータを結合している.all_rankingはモデルに記載している。
    @posts = Post.includes(:user, :tags, :post_tags).all_ranking
  end

  def destroy
    @post = Post.find_by(id: params[:id])
   if @post.destroy
     flash[:notice] = "投稿を削除しちゃった(*´σｰ｀)ｴﾍﾍ"
     redirect_to posts_path
   else
     render :index
   end
  end

  private

  def post_params
    # tag_idsは空の配列を入れてある。沢山作れるようにしている。
    params.require(:post).permit(:description, :post_title, :image, tag_ids: [])
  end
    #管理者のみ許可
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

end
