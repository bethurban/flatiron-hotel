Rails.application.routes.draw do
  root 'welcome#home'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
  post '/available' => 'bookings#new'
  post '/existing_bookings' => 'bookings#index'
  post '/available_rooms' => 'rooms#index'
  resources :users do
    resources :bookings, only: [:show, :index, :new, :create]
  end
  resources :bookings, only: [:index, :show, :edit, :update, :destroy]
  resources :rooms

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
