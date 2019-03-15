module Mutations
    class EditClient < BaseMutation
        argument :uuid, String, required: true
        argument :name, String, required: false
        argument :description, String, required: false

        type Types::ClientType

        def resolve(uuid: nil, name: nil, description: nil)
            client = Client.find_by!(uuid: uuid, user: context[:current_user])
            client.name = name if name
            client.description = description if description
            return client if client.save!
            
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end