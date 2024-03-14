Rails.application.routes.draw do
  # Defines the root path route ("/")
  
  root "dashboard#show"
  #root "disc_tests#new"
  resources :questions, only: [:index, :create]
  resources :users, only: [:create, :new]
  resource :session, controller: 'sessions', only: [:create, :new]

  get '/dashboard', to: 'dashboard#show', as: 'dashboard'

  get 'disc_tests/', to: 'disc_tests#new', as: 'new_disc_test'
  post 'disc_tests/calculate', to: 'disc_tests#calculate_result', as: 'disc_test_calculate_result'

  
  # # Use custom sessions controller for sign-in
  # Custom sign-in route
  get '/login' => 'sessions#new', as: 'signin'
  delete '/logout' => 'sessions#destroy', as: 'signout'
  get '/signup' => 'users#new', as: 'signup'

  # Password Reset
  get 'change_password' => 'users#edit_password', as: :edit_password
  patch 'update_password' => 'users#update_password', as: :update_password


  get 'disc_tests/result/:id', to: 'disc_tests#result', as: 'disc_test_result'
  
  # Catch-all route for unmatched routes
  # match '*path', to: 'application#render_404', via: :all
end
