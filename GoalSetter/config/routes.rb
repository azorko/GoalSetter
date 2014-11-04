Rails.application.routes.draw do
  root to: "users#index"
  resource :session
  resources :users
  resources :goals
  resources :comments
end
