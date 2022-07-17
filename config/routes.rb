Rails.application.routes.draw do
  resources :accounts do
    root "accounts#index"

  end
end
