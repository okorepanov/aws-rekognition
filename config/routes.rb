Rails.application.routes.draw do
  devise_for :users

  resources :media

  resources :images
  resources :videos

  root to: "media#index"
end
