Rails.application.routes.draw do
  root to: 'items#index'

  resources :items, only: [:show, :edit, :new]


  resources :users, only: [:index, :show, :new]
  get 'users/new/:name',controller: 'users', action: 'new'


  

  resources :users, only: [:index, :show]
  get 'users/new/:name', controller: 'users', action: 'create'


  get 'users/edit/:name', controller: 'users', action: 'edit'
end
