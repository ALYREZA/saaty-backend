module Types
    class SaatType < BaseObject
        field :value, GraphQL::Types::ISO8601DateTime,null: false
        field :project, Types::ProjectType, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
end