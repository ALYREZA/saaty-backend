module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
  end
end
