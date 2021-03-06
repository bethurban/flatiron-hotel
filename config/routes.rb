Rails.application.routes.draw do
  root 'welcome#home'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  post '/existing_bookings' => 'bookings#index'
  post '/available_rooms' => 'rooms#index'
  resources :users do
    resources :bookings, only: [:show, :index, :new, :create]
    post '/available' => 'bookings#new'
  end
  resources :bookings, only: [:index, :show]
  get '/rooms/cost' => 'rooms#cost'
  resources :rooms, only: [:index, :show, :new, :create]
  get '/auth/facebook/callback' => 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
