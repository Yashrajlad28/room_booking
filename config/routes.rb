Rails.application.routes.draw do
  devise_for :users

  root "api/v2/bookings#index"

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
      resources :bookings, only: [:index, :new, :create]
    end
  end
end
