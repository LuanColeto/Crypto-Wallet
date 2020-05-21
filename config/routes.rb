Rails.application.routes.draw do
  get 'test/index'
  resources :mining_types
  resources :coins

  get '/inicio', to: 'welcome#index'

  root to: "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
