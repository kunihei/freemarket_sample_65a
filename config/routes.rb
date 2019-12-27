Rails.application.routes.draw do
  root to: 'items#index'

  resources :items, only: [:show, :edit]

  resources :users, only: [:index, :show, :new]
  get 'users/new/:name',controller: 'users', action: 'new'
  get 'users/edit/:name', controller: 'users', action: 'edit'
end
