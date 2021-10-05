class Batch::DataReset
  def self.data_reset
    # 投稿を全て削除
    Notification.delete_all
    p "通知を全て削除しました(￣ー￣)ﾆﾔﾘ"
  end
end