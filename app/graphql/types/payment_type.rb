module Types
    class PaymentType < BasicObject
        field :order_id, String, null: false
        field :status, Int, null: false
        field :track_id, Int, null: true
        field :payment_id, String, null: false
        field :amount, Int, null: true
        field :card_no, String, null: true
        field :user, Types::UserType, null: false
        field :payment_date, GraphQL::Types::ISO8601DateTime, null: true
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
end