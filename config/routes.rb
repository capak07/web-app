Rails.application.routes.draw do
  resources :users
    resources :accounts do
      member do
        get '/transact', to: 'accounts#transact', as: 'transact'
        get '/debit', to: 'accounts#debit', as: 'debit'
        patch '/deposit', to: 'accounts#deposit', as: 'deposit'
        patch '/withdraw', to: 'accounts#withdraw', as: 'withdraw'
      end
    end
  root 'pages#home'
  get 'pages/about'
end
