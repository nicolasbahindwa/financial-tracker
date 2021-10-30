Rails.application.routes.draw do

  resources :user_stocks, only: [:create, :destroy]
  get 'users/my_portfolio'
  get 'search_stock', to: 'stocks#search'
  devise_for :users
  root 'welcome#index'

  get 'my_friends', to: 'friendships#index'
  get "search_friend", to: "friendships#search"
  resources :friendships, only: [:create, :destroy]
  resources :users, only:[:show]
  # get 'my_portfolio', to: 'users#my_portfolio'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
