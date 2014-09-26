class ContactsController < ApplicationController
  def new
    @diary   = Contact.import(current_user.try(:email), session[:token])
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    if @contact.valid?
      @contact.send(current_user)
      redirect_to contact_path, notice: "Message was successfully sent."
    else
      @diary = Contact.import(current_user.try(:email), session[:token])
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
end
