# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users_admin

  root to: 'home#index'

  ActiveSupport::Notifications.instrument 'routes_loaded.application'
end
