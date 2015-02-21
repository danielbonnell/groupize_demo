Rails.application.routes.draw do
  root 'plays#index'
  resources :plays, only: [:index]
end
