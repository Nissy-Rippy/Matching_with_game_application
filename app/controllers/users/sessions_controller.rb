# frozen_string_literal: true

before_action :reject_user, { only: [:withdraw] }
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # 退会アカウントで再度ログインする方を防ぐコード
  def reject_user
    @user = User.finde_by(params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        flash[:notice] = "退会してたなんてﾟ(ﾟ´Д｀ﾟ)ﾟ"
        redirect_to root_path
      end
    end
  end
end
