# frozen_string_literal: true

Rails.application.routes.draw do
  resources :kudos
  devise_for :admins,path: 'admins',path_names: {
    sign_in: '/', sign_out: 'logout',
    password: 'secret', confirmation: 'verification',
    registration: 'register', edit: 'edit/profile'
  }, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :employees, path: 'employees', controllers: {
    sessions: 'employees/sessions'
  }
  namespace :admins do
    get "/dashboard", to: "pages#dashboard"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "kudos#index"
end
