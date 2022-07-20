# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[new create] 
  devise_for :employees, path: 'employees'
  resources :employees do
    member do
      resources :orders, only: %i[index show]
      get "orders", to: "order#index"
    end
  end
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    resources :kudos
    resources :employees, except: :create do
      member do
        resources :orders, only: %i[index show] , as: 'employee_orders'
      end
    end
    resources :rewards
    resources :company_values

    root to: 'pages#dashboard'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'kudos#index'
end
