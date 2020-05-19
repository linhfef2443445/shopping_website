# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, skip: :all
  as :user do
    get "/login" => "devise/sessions#new", :as => :new_user_session
    post "/login" => "devise/sessions#create", :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
    get "/register" => "devise/registrations#new", :as => :new_user_registration
    post "/register" => "devise/registrations#create", :as => :user_registration
  end

  namespace :manager do
    root "static_pages#index"
    resources :users
    resources :products
    resources :orders, except: %i[new create]
    resources :blogs
    resources :reviews
    resources :comments
  end

  resources :users, only: %i[show edit update]

  devise_for :admins, controllers: {
    sessions: "manager/sessions"
  }, path: :manager

  get "/shop", to: "products#index"
  root "static_page#index"
  get "/card/new" => "billings#new_card", as: :add_payment_method
  post "/card" => "billings#create_card", as: :create_payment_method
  get "/success" => "billings#success", as: :success
  post "/payment" => "billings#payment", as: :payment
  post "/payment" => "billings#payment_from_order", as: :payment_order
  
  resources :products, only: [:show]
  resources :reviews, only: %i[create new show index]
  resources :carts, only: %i[index create destroy update]
  resources :checkouts, only: %i[index create new]
  resources :orders, only: %i[update show index]
  resources :blogs
  resources :comments, only: %i[create new show index]
  resources :billings, only: [:index]
end
