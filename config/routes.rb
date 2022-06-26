Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'auth/register', to: 'users#create'
  post 'auth/login', to: 'users#login'
  get 'ali', to: 'users#ali' #test
  # Defines the root path route ("/")
  # root "articles#index"
end
