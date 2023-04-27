Rails.application.routes.draw do
    devise_for :users
  
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
    # Defines the root path route ("/")
    # root "articles#index"
    root "recipes#public"
  get '/public_recipes', to: 'recipes#public'
  get '/shopping_list', to: 'shopping_list#index'
  resources :users
  resources :foods 
  resources :recipes do
    resources:recipe_foods 
  end
  
  end