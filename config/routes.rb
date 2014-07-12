Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :accounts do
    member do
      post 'create_transaction'
    end
  end

  resources :transactions, :only => [:destroy]

end
