Rails.application.routes.draw do
  resources :users
  resources :articles, only: [:create]
end
