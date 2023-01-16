Rails.application.routes.draw do
  devise_for :users
  resources :playlists
  resources :songs do 
    post :add, on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_scope :user do
    root 'devise/sessions#new'
  end
end
