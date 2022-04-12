Rails.application.routes.draw do

  resources :users, only: [:index, :create]
  resources :enemies, only: [:update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
