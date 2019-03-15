module Mutations
    class CreateClient < BaseMutation
        argument :name, String, required: true
        argument :description, String, required: false
        type Types::ClientType

        def resolve(name: nil, description: nil)
            Client.create!(
                name: name,
                uuid: UUIDTools::UUID.random_create,
                user: context[:current_user],
                description: description
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end