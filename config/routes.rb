Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :api_keys, only: [:create]
      resources :api_key_revocations, only: [:create]
    end
  end
end
