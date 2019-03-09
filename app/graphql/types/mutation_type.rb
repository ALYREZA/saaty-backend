module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
    field :create_client, mutation: Mutations::CreateClient
  end
end
