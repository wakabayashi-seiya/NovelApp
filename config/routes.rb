Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root 'static_pages#home'
  get '/help', to: "static_pages#help"
  get '/about', to: "static_pages#about"
  get '/box', to: "static_pages#box"
  get '/search', to: "static_pages#search"

  get '/sf', to: "genre_novels#sf"
  get '/dw', to: "genre_novels#dw"
  get '/cw', to: "genre_novels#cw"
  get '/love', to: "genre_novels#love"
  get '/horror', to: "genre_novels#horror"
  get '/mystery', to: "genre_novels#mystery"
  get '/suspense', to: "genre_novels#suspense"
  get '/essay', to: "genre_novels#essay"
  get '/history', to: "genre_novels#history"

  get '/complete', to: "complete_imcomplete_novels#complete"
  get '/incomplete', to: "complete_imcomplete_novels#incomplete"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :users
  resources :notes
  resources :novels do
    resources :stories, :reviews
  end
  resources :favorites, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
