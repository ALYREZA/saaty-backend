module Mutations
    class StartRecord < BaseMutation
        argument :start, String, required: true
        argument :project_uuid, String, required: true

        type Types::SaatType

        def resolve(start: nil, client_uuid: nil, project_uuid: nil)
            project = Project.find_by!(uuid: project_uuid, user: context[:current_user])
            Saat.create!(
                uuid: UUIDTools::UUID.random_create,
                start: Chronic.parse(start.to_s, :context => :past, :now => Time.zone.now) ? Chronic.parse(start.to_s, :context => :past, :now => Time.zone.now) : Chronic.parse("this second", :context => :past, :now => Time.zone.now),
                client: project.client,
                user: context[:current_user],
                project: project
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end
    end
end