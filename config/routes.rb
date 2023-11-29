Rails.application.routes.draw do
  root 'shangri_la#index'
  get 'shangri_la/index'

  
  resources :users
end
