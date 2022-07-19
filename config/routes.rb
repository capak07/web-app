Rails.application.routes.draw do
  resources :accounts do
    member do
      get :deposit
      get :withdraw
    end
  end
  root 'pages#home'
  get 'pages/about'
  get '/accounts/:id/transact', to: 'accounts#transact', as: 'transact'
  patch '/accounts/:id/credit', to: 'accounts#credit', as: 'credit'
end
