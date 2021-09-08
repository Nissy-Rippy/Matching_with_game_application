class ContactMailer < ApplicationMailer
 
   def send_when_sign_up(email, name)
    @name = name#viewページで名前を表示させるためのコード
    mail to: email,#新規登録時のe-mailアドレス
         subject: "登録完了のお知らせです(^^ゞ、あなたのしあわせを願っています "
   end

end
