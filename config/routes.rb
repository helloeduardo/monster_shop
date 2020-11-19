Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  # resources :merchants do
  #   resources :items, only: [:index]
  # end
  get 'merchants', to: 'merchants#index'
  post 'merchants', to: 'merchants#create'
  get 'merchants/new', to: 'merchants#new'
  get 'merchants/:id', to: 'merchants#show', as: :merchant
  get 'merchants/:id/edit', to: 'merchants#edit'
  patch 'merchants/:id', to: 'merchants#update'
  delete 'merchants/:id', to: 'merchants#destroy'
  get 'merchants/:merchant_id/items', to: 'items#index'

  # resources :items, only: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
  # end
  get 'items', to: 'items#index', as: :items
  get 'items/:id', to: 'items#show', as: :item
  get 'items/:item_id/reviews/new', to: 'reviews#new', as: :new_item_review
  post 'items/:item_id/reviews', to: 'reviews#create', as: :item_reviews

  # resources :reviews, only: [:edit, :update, :destroy]
  get 'reviews/:id/edit', to: 'reviews#edit', as: :edit_review
  patch 'reviews/:id', to: 'reviews#update'
  delete 'reviews/:id', to: 'reviews#destroy', as: :review

  # get '/cart', to: 'cart#show'
  # post '/cart/:item_id', to: 'cart#add_item'
  # delete '/cart', to: 'cart#empty'
  # patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  # delete '/cart/:item_id', to: 'cart#remove_item'
  scope :cart do
    get '/', to: 'cart#show', as: :cart
    post '/:item_id', to: 'cart#add_item'
    delete '/', to: 'cart#empty'
    patch '/:change/:item_id', to: 'cart#update_quantity'
    delete '/:item_id', to: 'cart#remove_item'
  end

  get '/registration', to: 'users#new', as: :registration
  # resources :users, only: [:create, :update]
  post '/users/', to: 'users#create'
  patch '/users/:id', to: 'users#update', as: :user

  patch '/user/:id', to: 'users#update'

  scope :profile do
    get '/', to: 'users#show', as: :profile
    get '/edit', to: 'users#edit'
    get '/edit_password', to: 'users#edit_password'
    get '/orders', to: 'user/orders#index'
    get '/orders/:id', to: 'user/orders#show'
    delete '/orders/:id', to: 'user/orders#cancel'
  end

  post '/orders', to: 'user/orders#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  namespace :merchant do
    get '/', to: 'dashboard#index', as: :dashboard
    # resources :orders, only: :show
    get '/orders/:id', to: 'orders#show'

    # resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    get '/items', to: 'items#index'
    post '/items', to: 'items#create'
    get '/items/new', to: 'items#new'
    get '/items/:id/edit', to: 'items#edit'
    patch '/items/:id', to: 'items#update'
    put '/items/:id', to: 'items#update'
    delete '/items/:id', to: 'items#destroy'

    put '/items/:id/change_status', to: 'items#change_status'
    get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'

    resources :discounts
  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :merchants, only: [:show, :update]
    resources :users, only: [:index, :show]
    patch '/orders/:id/ship', to: 'orders#ship'
  end
end
