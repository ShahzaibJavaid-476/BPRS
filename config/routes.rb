Rails.application.routes.draw do
  devise_for :users
  resource :profile, only: [:show, :edit, :update]
  devise_scope :user do
    get 'buyer/sign_in', to: 'devise/sessions#new', as: :new_buyer_session
  end  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :buyers, only: [:new, :create, :edit, :destroy]
    resources :plans
    resources :features
    resources :subscriptions
  end
  
  namespace :buyer do
    get 'dashboard', to: 'dashboard#index'
    resources :plans, only: [:index, :show] do
      resources :subscriptions, only: [:new, :create]
    end
  end
end
