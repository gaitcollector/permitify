Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resource :dashboard, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :permits do
    resources :bookings, only: [:new, :create, :destroy]
  end
  resources :bookings, only: [:show, :edit, :update, :destroy]
end
