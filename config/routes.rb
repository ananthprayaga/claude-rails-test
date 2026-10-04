Rails.application.routes.draw do
  resources :ideas do
    patch :toggle_star, on: :member
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  root "ideas#index"
end
