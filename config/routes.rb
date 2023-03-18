Rails.application.routes.draw do
  resources :businesses do
    resources :members
    post '/invite', to: 'businesses#invite', as: :invite
  end
  devise_for :users
  
  get "dashboard", to: "dashboard#index"
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
