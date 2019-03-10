module Types
    class SaatType < BaseObject
        field :uuid, String, null: false
        field :start, GraphQL::Types::ISO8601DateTime,null: false
        field :end, GraphQL::Types::ISO8601DateTime,null: true
        field :duration, Float, null: true
        field :project, Types::ProjectType, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
end