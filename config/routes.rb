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
    resources :employees, except: :create
    resources :rewards
    resources :company_values
    patch "/admins/orders/:id(.:format)", to: "orders#deliver", as: "order"
    root to: 'pages#dashboard'
  end
  scope module: 'employees' do
    resources :kudos
    resources :rewards, only: %i[index show]
    resources :orders, only: %i[new create]
    resources :employees do
      member do
        resources :orders, only: :index
        get 'orders', to: 'order#index'
      end
    end
    root to: 'kudos#index'
  end
end
