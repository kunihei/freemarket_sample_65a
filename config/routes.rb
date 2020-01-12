Rails.application.routes.draw do

  root to: 'items#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }
  devise_scope :user do
    get 'tellphone',  to: 'users/registrations#new_tellphone'
    post 'tellphone', to: 'users/registrations#create_tellphone'
    get 'addresses',  to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'cards',      to: 'users/registrations#new_cards'
    post 'cards',     to: 'users/registrations#create_cards'
    get 'finish',     to: 'users/registrations#new_finish'
    post 'finish',    to: 'users/registrations#create_finish'
  end

  get 'users/edit/:name/:id', controller: 'users', action: 'edit'
  resources :users do
    member do
      get :item_exhibit
      get :item_negotiate
      get :item_buyed
    end
  end
  resources :user_addresses,        only: [:update]
  resources :user_identifications, only: [:update]
  resources :user_pass,       only: [:update]
  resources :user_tells,            only: [:update]

  resources :items do
    resources :likes, only: [:create, :destroy]
    member do
      get 'buy_confirmation'
      post'pay'
      get 'categories'
      get 'prefectures'
      get 'transaction'
      post'transaction_update'
      post'evaluation_update'
    end
    collection do
      get 'search'
    end
  end
end
