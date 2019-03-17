module Mutations
    class DeleteProjects < BaseMutation
        argument :uuids, [String], required: true

        type [Types::ProjectType]

        def resolve(uuids: nil)
            project = Project.where(uuid: uuids, user: context[:current_user]).destroy_all            
            return project
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end