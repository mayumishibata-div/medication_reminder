Rails.application.routes.draw do
  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index' #(仮)
  # Defines the root path route ("/")
  # root "posts#index"
end
