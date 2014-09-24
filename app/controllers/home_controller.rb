class HomeController < ApplicationController
  def show
    @contacts = Contact.import(current_user.try(:email), session[:token])
  end
end
