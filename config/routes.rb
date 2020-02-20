Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                    sessions: 'users/sessions',
                                    registrations: 'users/registrations'}

  devise_scope :user do
    post 'users/quik_register', to: 'users/registrations#quik_register'
  end

  root 'pages#home'

  resources :addresses, only: %i[index create update]
  resources :order_items
  resources :orders
  resource  :coupon, only: :update
  resources :checkout

  resources :books, only: %i[index show]  do
    resources :reviews, only: :create
  end
end
