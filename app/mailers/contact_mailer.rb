class ContactMailer < ApplicationMailer
 
   def send_when_sign_up(email, name)
    @name = name#viewページで名前を表示させるためのコード
    mail to: email,#新規登録時のe-mailアドレス
         subject: "登録完了のお知らせです(^^ゞ、あなたのしあわせを願っています "
   end
   
   def send_mail(contact)
     @contact = contact
     mail(
       to: '6089more@gmail.com',
       subject: "お問い合わせ内容"
       )
   end

end
