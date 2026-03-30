Rails.application.routes.draw do

  devise_for :users

  root "welcome#index"

  namespace :api do
    namespace :v1 do
      resources :rooms, only: [:index, :show] do
        collection do
          get :search
        end
      end
      resources :bookings, only: [:index, :create, :destroy]
    end

    namespace :v2 do
      resources :bookings do
        member do
          patch :cancel
        end
      end

      resources :rooms

    end
  end
end
