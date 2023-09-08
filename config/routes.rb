Rails.application.routes.draw do
  devise_for :users

  resources :media

  resources :images
  resources :videos

  root to: "images#index"
end
