Rails.application.routes.draw do
  resources :businesses do
    resources :products
    resources :members do
      put 'block', to: 'businesses#block_user', as: :block_user
      put 'unblock', to: 'businesses#unblock_user', as: :unblock_user
    end
    post '/invite', to: 'businesses#invite', as: :invite
    post '/resend_invitation/:member_id', to: 'businesses#resend_invitation', as: :resend_invitation
    delete 'businesses/:business_id/members/:id', to: 'businesses#remove_member', as: :remove_member

  end

  devise_for :users
  
  get "dashboard", to: "dashboard#index"
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
