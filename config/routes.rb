Rails.application.routes.draw do
  resources :businesses do
    resources :members
    post '/invite', to: 'businesses#invite', as: :invite
    # post '/resend_invitation', to: 'businesses#resend_invitation', as: :resend_invitation
    post '/resend_invitation/:member_id', to: 'businesses#resend_invitation', as: :resend_invitation
  end
  devise_for :users
  
  get "dashboard", to: "dashboard#index"
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
