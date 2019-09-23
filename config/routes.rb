Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                       :registrations => 'users/registrations' }
  root 'pages#home'

  resources :books, only: %i[index show]
  resources :addresses,  only: %i[index create update]
end
