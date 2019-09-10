Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :books, only: %i[index show]
end
