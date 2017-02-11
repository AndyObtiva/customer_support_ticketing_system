Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :reports
  resources :comments
  resources :tickets
  devise_for :users

  get "/pages/*id" => 'pages#show', as: :page, format: false
  root to: 'pages#show', id: 'home'
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
