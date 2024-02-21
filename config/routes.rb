Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "disc_tests#new"
  resources :questions, only: [:index, :create]
  resources :users, only: [:create, :new]
  resource :session, controller: 'sessions', only: [:create, :new]

  get 'disc_tests/', to: 'disc_tests#new', as: 'new_disc_test'
  post 'disc_tests/result', to: 'disc_tests#result', as: 'disc_test_result'

  # # Use custom sessions controller for sign-in
  # resources :sessions, controller: 'sessions', only: [:create]

  # Custom sign-in route (optional)
  get '/signin' => 'sessions#new', as: 'signin'
  delete '/signout' => 'sessions#destroy', as: 'signout'

  get '/register' => 'users#new', as: 'signup'
end
