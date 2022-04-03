Rails.application.routes.draw do
  resources :messages
  devise_for :users
  root 'messages#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  put '/messages/:id/like', to: 'likes#create', as: 'like'
  delete '/messages/:id/unlike', to: 'likes#destroy', as: 'unlike'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
