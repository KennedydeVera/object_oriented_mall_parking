Rails.application.routes.draw do
  get 'parking_allocations/index'
  get 'parking_allocations/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Define the resources route for parking_allocations
  resources :parking_allocations, only: [:index, :create]
  get '/get_vehicle_type', to: 'parking_allocations#get_vehicle_type'

  get '/calculate_fee', to: 'parking_allocations#calculate_fee'
  post 'exit_parking', to: 'parking_allocations#exit_parking'
  root 'parking_allocations#index'
  
end
