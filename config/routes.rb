Rails.application.routes.draw do
  root 'shangri_la#index'
  get 'shangri_la/index'

  get 'shangri_la/login_form'
  post 'shangri_la/login'
  get 'shangri_la/logout'
 
  resources :users
end
