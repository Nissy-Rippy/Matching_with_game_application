class NotificationsController < ApplicationController
  before_action :ensure_authenticate, only: [:destroy_all]
  def index
    # 現在ログインしている人に紐づく通知一覧。N+1  問題解決のため行っています。
    @notifications = Notification.includes(:visitor, :visited)
    # このコードは、indexを開いてない未読の通知のみを集めている。
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    # 通知を全削除するためのコード
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

  private

  def ensure_authenticate
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user)
    end
  end
end
