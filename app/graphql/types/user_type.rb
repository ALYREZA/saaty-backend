module Types
    class UserType < BaseObject
        field :id, ID, null: false
        field :name, String, null: false
        field :email, String, null: false
        field :password, String, null: false
        field :zone, String, null: false
        field :status, Int, null: false
        # field :is_admin, Int, null: false
        field :plan, Int, null: false
        field :projects_count, Int, null: false
        field :clients_count, Int, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
        field :expired_at, GraphQL::Types::ISO8601DateTime, null: true
    end
end