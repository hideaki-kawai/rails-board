Rails.application.routes.draw do

  # get 'users/me'
  get 'mypage', to: 'users#me'

  # get 'sessions/create'
  # get 'sessions/destroy'
  post 'login', to: 'sessions#create' 
  delete 'logout', to: 'sessions#destroy' 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'boards#index'
  # get 'boards', to: 'boards#index'
  # get 'boards/new', to: 'boards#new'
  # post 'boards', to: 'boards#create'
  # get 'boards/:id', to: 'boards#show'
  # resources :boards, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :boards
  # get 'comments/create'
  # get 'comments/destroy'
  resources :comments, only: %i[create destroy]
  
  # get 'users/new'
  # get 'users/create'
  resources :users, only: %i[new create]
end
