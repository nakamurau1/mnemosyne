Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post   '/guest_login', to: 'sessions#guest_login'
  post 'items/review'
  resources :users 
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :items
  resources :decks
  get '/public_decks', to: 'decks#public_index'
  post '/copy',        to: 'decks#copy'
  post '/stop_learning', to: 'decks#stop'
  post '/resume_learning', to: 'decks#resume'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
