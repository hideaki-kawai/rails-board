Rails.application.routes.draw do
  
  get 'users/new'

  get 'users/create'

  get 'users/me'

  get 'home/index'

  get 'sessions/create'

  get 'sessions/destroy'

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
end
