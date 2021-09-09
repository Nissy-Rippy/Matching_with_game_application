class NotificationsController < ApplicationController
  
  def index
    #現在ログインしている人に紐づく通知一覧。
    @notifications = current_user.passive_notifications
    #このコードは、indexを開いてない未読の通知のみを集めている。
    @notifications.where(checked: false).each do |notification|
    notification.update_attributes(checked: true)
    end
  end
  
  def destroy_all
    #通知を全削除するためのコード
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
