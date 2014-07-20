Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :accounts do
    member do
      post 'create_transaction'
      post 'create_schedule'
    end
  end

  resources :transactions, :only => [:destroy, :update]
  resources :schedules, :only => [:destroy, :update]

  get 'settings' => 'settings#index'
  post 'update_settings' => 'settings#update'

end
