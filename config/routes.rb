Rails.application.routes.draw do
  root 'pages#home'

  # resources :projects, only: [:show, :index, :new, :destroy, :edit]
  resources :projects
  resources :bugs
  devise_for :users, controllers: { sessions: 'users/sessions'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #devise_for :users, controllers: { sessions: 'users/sessions'}
  get "/projects", to: "projects#index"
  get "/bugs", to: "bugs#index"


end
