Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sensors#index'

  resources :sensors do
    resources :sensor_mesurements, only: [:index, :show] 
  end

  mount ActionCable.server => '/cable'
end
