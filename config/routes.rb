Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root to: 'items#index'

  resources :items, only: [:show, :edit]


  resources :users, only: [:index, :show, :new]
  get 'users/new/:name',controller: 'users', action: 'new'


  

  resources :users, only: [:index, :show]
  get 'users/new/:name', controller: 'users', action: 'create'
  get 'users/edit/:name', controller: 'users', action: 'edit'

end
