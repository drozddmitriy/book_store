Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                       :registrations => 'users/registrations' }
  root 'pages#home'

  resources :addresses,  only: %i[index create update]
  resources :line_items

  resources :books, only: %i[index show]  do
    resources :reviews, only: :create
  end

end
