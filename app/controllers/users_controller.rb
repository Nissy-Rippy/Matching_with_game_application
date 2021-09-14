class UsersController < ApplicationController
 before_action :set_user

  def index
   #フォロ―ランキング上位4位の方を表示したい
   # @users_ranking = User.where.not(id: current_user.id).page(params[:page]).per(8).order("")

   #自分以外のユーザーのデータを取得、降順にしておりかみなりで24件ごとにページを作る
  #@users = User.where.not(id: current_user.id).page(params[:page]).per(24).order("created_at DESC")
  @users = User.all.shuffle
  
  
  end

  def show
      @user = User.find(params[:id])
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
      user = User.find(params[:id])
      if user.update(user_params)
          redirect_to user_path(user)
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

  end
  
  def search
   @users = User.search(params[:keyword])
   @keyword = params[:keyword]
   render :index
  end


 private

  def user_params
      params.require(:user).permit(:name,:age,:introduction,:address,:playing_game,:profile_image,:is_deleted)
  end
  
  def set_user

  end
end
