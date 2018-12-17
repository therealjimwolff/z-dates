Rails.application.routes.draw do
  get 'static_pages/_landing' => 'static_pages#_landing'
  get 'static_pages/home' => 'static_pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations'}

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  resources :users, only: %i[show index] do
    get '/friend_requests', to: 'friend_requests#index'
    get '/friends', to: 'friendships#index'
  end

  resources :friend_requests, only: %i[create update destroy]
  resources :friendships, only: :destroy
  resources :posts, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  resources :comments, only: %i[create update destroy]

  root 'static_pages#home'
end
