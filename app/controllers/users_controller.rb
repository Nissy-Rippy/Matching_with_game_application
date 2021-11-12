class UsersController < ApplicationController
  before_action :ensure_authenticate, only: [:update, :destroy, :edit]

  def index
    # userをランダムにシャッフルに並べる記述
    @users = User.all.shuffle
  end

  def show
    @user = User.find(params[:id])
    @video = Video.find_by(user_id: @user.id)
    # @userに紐づくposts投稿記事のデータを取得。
    @posts = @user.posts.includes(:tags, :post_tags)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    begin
      user = User.find(params[:id])
      if user.update(user_params)
        redirect_to user_path(user)
      else
        render :edit
      end
    rescue
      flash[:notice] = "IDが取得できませんでした！ごめんなさい！"
      redirect_to user_path(user)
    end
  end

  def withdraw
    @user = current_user
    #is_deletedのあたいだけupdateする
    @user.update(is_deleted: true)
    #reset_Sessionにより、userのデータを消去する
    reset_session
    flash[:notice] = "またのご利用を心より願っています(^^ゞ"
    redirect_to root_path
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  #userの検索機能
  def search
    #@usersには検索により発見されたuserデータを格納
   @users = User.search(params[:keyword])
    #@keywordは検索ツールに打ち込んだデータを取得している。
   @keyword = params[:keyword]
   render :index
  end
private

  def user_params
    params.require(:user).permit(:name, :age, :introduction, :address, :playing_game, :profile_image, :is_deleted)
  end
  #urlを直接打ち込んでも使えないように設定しています
  def ensure_authenticate
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user)
    end
  end

end
