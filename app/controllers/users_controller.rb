class UsersController < ApplicationController
  before_action :set_user
  before_action :ensure_authenticate, only: [:update, :destroy, :edit]

  def index
    # userをランダムにシャッフルに並べる記述
    @users = User.all.shuffle
  end

  def show
    @user = User.find(params[:id])
    # @userに紐づくposts投稿記事のデータを取得。
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user)
    else
      render :edit
    end
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "またのご利用を心より願っています(^^ゞ"
    redirect_to root_path
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render :index
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :introduction, :address, :playing_game, :profile_image, :is_deleted)
  end

  def ensure_authenticate
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user)
    end
  end

  def set_user
  end
end
