Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :countries do
  get 'nearby', on: :member
    resources :bookings, only: %i[create new]
  end
  resources :bookings, only: %i[index destroy show] do
    resources :reviews, only: %i[create]
  end
  resources :reviews, only: [:destroy]

   direct :rails_direct_uploads do
    "https://api.cloudinary.com/v1_1/#{ENV['CLOUDINARY_CLOUD_NAME']}/auto/upload"
  end
end
