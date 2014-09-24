Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  # You can have the root of your site routed with "root"
  root 'home#show'
end
