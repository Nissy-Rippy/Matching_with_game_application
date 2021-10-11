# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = Rails.env.to_sym || :production || :development
#cronを実行する環境設定のセット
set :environment, rails_env
#ログの出力先を指定している。
set :output, 'log/cron.log'
#毎週日曜日の昼の１２時に発動するように設定する
every :sunday, at: '12pm' do
  #例外処理beginでエラーが発生しそうな処理を指定。rescueでエラーが発生した場合の処理を記入
  begin
    runner "Batch::DataReset.data_reset"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end

end
