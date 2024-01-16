Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  root 'shangri_la#index'
  get 'shangri_la/index'

  get 'shangri_la/login_form'
  post 'shangri_la/login'
  get 'shangri_la/logout'
  post 'shangri_la/search'
 
  resources :users
end
