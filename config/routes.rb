Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :todos
    end
  end

  root to: 'home#index'
end
