Rails.application.routes.draw do
  root to: 'items#index'

  resources :items, only: [:show, :edit]

  resources :users, only: [:index, :show, ]
  get 'users/edit/:name', controller: 'users', action: 'edit'
end
