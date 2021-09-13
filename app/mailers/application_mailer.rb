class ApplicationMailer < ActionMailer::Base
  default from: ENV["KEY"]#送り主のメールアドレス
  layout 'mailer'
end
