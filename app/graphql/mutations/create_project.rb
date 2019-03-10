module Mutations
    class CreateProject < BaseMutation
        argument :name, String, required: true
        argument :client_uuid, String, required: true
        argument :color, String, required: false
        argument :description, String, required: false
        argument :estimate, Int, required: false
        argument :cost, Float, required: false
        type Types::ProjectType

        def resolve(name:nil, client_uuid: nil, color: nil, description: nil, estimate: nil, cost: nil)
            Project.create!(
                name: name,
                uuid: UUIDTools::UUID.random_create,
                user: context[:current_user],
                client: Client.find_by!(uuid: client_uuid, user: context[:current_user]),
                color: color ? color : SecureRandom.hex(3),
                description: description,
                estimate: estimate,
                cost: cost

            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end