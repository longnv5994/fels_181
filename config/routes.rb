Rails.application.routes.draw do
  root "static_pages#home"
  get "sessions/new"
  get "static_pages/help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/help", to: "static_pages#help"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/get_words", to: "words#get_words"
  resources :users, except: :delete
  resources :categories, except: [:new]
  resources :words
  namespace :admin do
    resources :categories
    resources :users
    resources :words do
      resources :word_answers, only: :index
    end
  end
end
