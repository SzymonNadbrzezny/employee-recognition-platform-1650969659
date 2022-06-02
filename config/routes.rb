# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  resources :kudos
  resources :rewards, only: %i[index show]
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :employees, path: 'employees'
  namespace :admins do
    resources :kudos
    resources :employees, except: :create
    resources :rewards
    resources :company_values

    root to: 'pages#dashboard'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'kudos#index'
end
