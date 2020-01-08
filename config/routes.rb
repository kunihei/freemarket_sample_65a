Rails.application.routes.draw do

  get 'card/new'
  get 'card/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
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





  resources :users, only: [:index, :show, :new] do
    member do
      get :item_exhibit
      get :item_negotiate
      get :item_buyed
    end
  end

  resources :items do
    member do
      get 'buy_confirmation'
      post 'pay'
      get 'categories',  controller: 'items', action: 'categories'
    end
  end
  


  get 'users/new/:name',controller: 'users', action: 'new'

  resources :users, only: [:index, :show, :new]
  get 'users/edit/:name', controller: 'users', action: 'edit'


end
