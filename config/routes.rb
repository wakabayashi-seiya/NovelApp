Rails.application.routes.draw do
  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root 'static_pages#home'
  get '/help', to: "static_pages#help"
  get '/about', to: "static_pages#about"
  get '/box', to: "static_pages#box"
  get '/search', to: "novels#search"
  
  get '/sf', to: "novels#sf"
  get '/dw', to: "novels#dw"
  get '/cw', to: "novels#cw"
  get '/love', to: "novels#love"
  get '/horror', to: "novels#horror"
  get '/mystery', to: "novels#mystery"
  get '/suspense', to: "novels#suspense"
  get '/essay', to: "novels#essay"
  get '/history', to: "novels#history"
  
  get '/complete', to: "novels#complete"
  get '/incomplete', to: "novels#incomplete"
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/set', to: "users#set"
  
  resources :users 
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :notes
  resources :novels do
    resources :stories, :reviews
  end
  resources :favorites, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
