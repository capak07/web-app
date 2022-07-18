Rails.application.routes.draw do
  resources :accounts
  root 'accounts#home'
  get 'home/about'
  get '/accounts/:id/transact', to: 'accounts#transact', as: 'transact'
  patch 'accounts/:id/transact', to: 'accounts#credit', as: 'credit'
end
