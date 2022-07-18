Rails.application.routes.draw do
  resources :accounts
  root 'accounts#home'
  get 'home/about'
end
