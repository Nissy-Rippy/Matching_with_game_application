# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact
    contact = Contact.new(name: "Nissy", message: "お問い合わせメッセージ")
    ContactMailer.send_mail(contact)
  end
  end
