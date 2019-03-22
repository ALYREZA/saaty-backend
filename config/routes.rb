Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/api/v1/graphql"
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope "/api/v1" do
    post "/graphql", to: "graphql#execute"
    get "/payment/callback", to: "payment#callback"
  end
end
