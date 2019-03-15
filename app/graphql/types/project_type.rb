module Types
    class ProjectType < BaseObject
        field :name, String, null: false
        field :uuid, String, null: false
        field :color, String, null: false
        field :client, Types::ClientType, null: false
        field :status, Int, null: false
        field :description, String, null: true
        field :cost, Float, null: true
        field :budget, Float, null: true
        field :budget_type, Int, null: true
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
end