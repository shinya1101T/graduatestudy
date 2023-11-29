Rails.application.routes.draw do
  namespace :admin do
      resources :likes
      resources :posts
      resources :replies
      resources :users

      root to: "likes#index"
    end
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "search_form" => "users#search_form"
  get "search" => "users#search"
  get "users/:id" => "users#show"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"
  get "users/:id/likes" => "users#likes"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/:id/Rcreate" => "posts#Rcreate"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/reply" => "posts#reply"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "/" => "home#top"
  get "about" => "home#about"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
