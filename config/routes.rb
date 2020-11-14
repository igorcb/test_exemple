Rails.application.routes.draw do
  resources :events
  get "home" => "home#index"
  root to: 'home#index'
end
