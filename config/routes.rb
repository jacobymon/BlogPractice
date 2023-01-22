Rails.application.routes.draw do
  get 'dashboards/index', as: :dashboards
resources :dashboards, only: [:get, :update, :edit, :post, :create, :show, :new, :index]
resources :logins, only:[:new, :create]

resources :registrations, only:[:new, :create, :index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
