Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :questions, only: [:index, :create]

  get 'disc_tests/', to: 'disc_tests#new', as: 'new_disc_test'
  post 'disc_tests/result', to: 'disc_tests#result', as: 'disc_test_result'
end
