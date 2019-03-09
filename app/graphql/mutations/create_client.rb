module Mutations
    class CreateClient < BaseMutation
        argument :name, String, required: true
        argument :user, Types::UserType, required: true

        type Types::ClientType

        def resolve(name: nil)
            Client.create!(
                name: name,
                uuid: UUIDTools::UUID.random_create,
                user: context[:current_user]
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end