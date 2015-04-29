Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope module: :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :menus, only: [:show]
    end
  end

    root to: 'admin/dashboard#index'

  end
