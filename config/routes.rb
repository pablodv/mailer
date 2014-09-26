Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  match 'contact' => 'contacts#new', as: :contact, via: :get
  match 'contact' => 'contacts#create', as: :create_contact, via: :post

  root 'contacts#new'
end
