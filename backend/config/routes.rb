Rails.application.routes.draw do  
  scope :api, defaults: {format: :json} do
    resources :public_contents, :private_contents
    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
      get 'finances/:user', to: 'finances#show'
    end
    post '/budgets/:user_id/:budget_name/:budget_value', to: 'budgets#create_budget'
    put '/budgets/:budget_id/:budget_name/:budget_value', to: 'budgets#edit_budget'
    get '/budgets/last-used-id', to: 'budgets#find_last_used_id'
    get '/budgets/:user_id', to: 'budgets#find_budgets'
    delete '/budgets/:budget_id', to: 'budgets#destroy_budget'
  end
end