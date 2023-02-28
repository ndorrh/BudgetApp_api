Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users
      resources :my_transactions
      resources :categories
      post '/auth/login', to: 'authentication#login'
    end
  end
  # resources :users
  # resources :my_transactions
  # post '/auth/login', to: 'authentication#login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
