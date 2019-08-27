Rails.application.routes.draw do
  root 'page#home'

  resources :books, only: %i[index show]
end
