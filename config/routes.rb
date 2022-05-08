# frozen_string_literal: true

Rails.application.routes.draw do
  resources :kudos
  devise_for :admins, path: "admins", controllers: {
                        sessions: "admins/sessions",
                      }
  devise_for :employees, path: "employees"
  namespace :admins do
    resources :kudos
    resources :employees

    root to: "pages#dashboard"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "kudos#index"
end
