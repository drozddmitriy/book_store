Rails.application.routes.draw do
  root 'pages#home'

  resources :books, only: %i[index show]
end
