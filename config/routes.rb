Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :todos do
        get :search, on: :collection
      end
    end
  end

  root to: 'home#index'
end
