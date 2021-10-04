class Admin::UsersController < ApplicationController
  #before_action :if_not_admin

  def index
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.is_deleted == false
     @user.update(is_deleted: true)
    else
     @user.update(is_deleted: false)
    end
    redirect_to request.referer
  end

private
  
  def user_params
    params.require(:user).permit(:name, :age, :introduction, :address, :playing_game, :profile_image, :is_deleted)
  end
  
  # def if_not_admin
  #   redirect_to root_path unless current_user.admin?
  # end

end
