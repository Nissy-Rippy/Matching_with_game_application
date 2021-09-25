class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
      flash[:notice] = "送信完了いたしました"
      redirect_to new_contact_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :message, :phone_number, :email)
  end
end
