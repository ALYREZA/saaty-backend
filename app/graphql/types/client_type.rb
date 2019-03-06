module Types
    class ClientType < BaseObject
        field :name, String, null: false
        field :uuid, String, null: false
        field :projects_count, Int, null: false
        field :user, Types::UserType, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
end