Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"

  scope module: :api, defaults: {format: 'json'} do
    namespace :v1 do
      post :sessions, controller: :sessions, action: :get_token
      delete :sessions, controller: :sessions, action: :clear_token
      resources :menus, only: [:show, :index]
      resources :orders do
        member do
          post :pay
        end
      end
      resources :users, only: [:create]
    end
  end

  root to: 'admin/dashboard#index'
end
