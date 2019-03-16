module Mutations
    class DeleteClient < BaseMutation
        argument :uuid, String, required: true

        type Types::ClientType

        def resolve(uuid: nil)
            client = Client.find_by!(uuid: uuid, user: context[:current_user])
            return client if client.destroy!
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end