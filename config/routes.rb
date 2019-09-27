Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
<<<<<<< HEAD
  
=======

>>>>>>> 9039dc3d43ee307f28b1328a50569a4039a47138
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                       :registrations => 'users/registrations' }
  root 'pages#home'

  resources :addresses,  only: %i[index create update]

  resources :books, only: %i[index show]  do
    resources :reviews, only: :create
  end

end
