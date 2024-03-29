# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :employees, path: 'employees'
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    resources :kudos
    resources :categories, except: :show
    resources :employees, except: :create do
      get :add_kudos, on: :collection, to: "employees#add_kudos_form"
      patch :add_kudos, on: :collection
    end
    resources :rewards do
      get :import, on: :collection, to: "rewards#import_form"
      post :import, on: :collection, to: "rewards#import"
    end
    resources :company_values
    patch "/orders/:id(.:format)", to: "orders#deliver", as: "order"
    get "/orders/export", to: "orders#export_to_csv", as: "orders_export"
    root to: 'pages#dashboard'
  end
  scope module: 'employees' do
    resources :kudos
    resources :rewards, only: %i[index show]  do
      get '(category/:category)(/page/:page)', action: :index, on: :collection, as: ''
    end
    resources :orders, only: %i[new create]
    resources :employees, only: %i[show update edit] do
      member do
        resources :orders, only: :index
        get 'orders', to: 'order#index'
      end
    end
    root to: 'kudos#index'
  end
end
