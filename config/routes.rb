Rails.application.routes.draw do

  get 'card/new'
  get 'card/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get 'tellphone', to: 'users/registrations#new_tellphone'
    post 'tellphone', to: 'users/registrations#create_tellphone'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'cards', to: 'users/registrations#new_cards'
    post 'cards', to: 'users/registrations#create_cards'
    get 'finish', to: 'users/registrations#new_finish'
    post 'finish', to: 'users/registrations#create_finish'
  end

  root to: 'items#index'


  resources :items, only: [:show, :edit, :new, :create] 


  resources :users, only: [:index, :show, :new]
  get 'users/new/:name',controller: 'users', action: 'new'


  resources :users, only: [:index, :show]
  get 'users/new/:name', controller: 'users', action: 'create'
  get 'users/edit/:name', controller: 'users', action: 'edit'


end
