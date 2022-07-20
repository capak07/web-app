Rails.application.routes.draw do
  resources :accounts do
    member do
      get '/transact', to: 'accounts#transact', as: 'transact'
      patch '/deposit', to: 'accounts#deposit', as: 'deposit'
      patch '/withdraw', to: 'accounts#withdraw', as: 'withdraw'
    end
  end
  root 'pages#home'
  get 'pages/about'
  patch '/accounts/:id/credit', to: 'accounts#credit', as: 'credit'
end
