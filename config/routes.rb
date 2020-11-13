Rails.application.routes.draw do
  get "home" => "home#index"
  root to: 'home#index'
end
